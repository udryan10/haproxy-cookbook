require_relative '../libraries/haproxy_helpers'

describe 'Haproxy::Helpers' do
  describe 'error' do
    it 'should return false' do
      expect(Haproxy::Helpers.error('fake error')).to be_falsey
    end
    it 'should log a chef error' do
      expect(Chef::Log).to receive(:error).with('fake error')
      Haproxy::Helpers.error('fake error')
    end
  end
  describe 'validate_required' do
    it 'should return true if no required schema objects are present' do
      fake_schema = { 'item' => { type: String, required: false } }
      expect(Haproxy::Helpers.validate_required(fake_schema)).to be_truthy
    end
    it 'should return false if a required schema object is present' do
      fake_schema = { 'item' => { type: String, required: true } }
      expect(Haproxy::Helpers.validate_required(fake_schema)).to be_falsey
    end
  end
  describe 'validate_type' do
    before(:each) do
      @fake_schema = {
        'item' => { type: String, required: false }
      }
    end
    it 'should return false if type does not match type expected in schema' do
      expect(Haproxy::Helpers.validate_type(false, 'item', @fake_schema))
    end
    it 'should return true if type matches type expected in schema' do
      expect(Haproxy::Helpers.validate_type('string', 'item', @fake_schema))
    end
  end
  describe 'validate_types' do
    before(:each) do
      @fake_schema = {
        'item1' => { type: String, required: false }
      }
    end
    it 'should return false on unknown schema item' do
      @fake_spec = {
        'foo' => 'bar'
      }
      expect(Haproxy::Helpers.validate_types(@fake_spec, @fake_schema)).to be_falsey
    end
    it 'should return false if type is a boolean but schema does not expect a boolean' do
      @fake_spec = {
        'foo' => false
      }
      expect(Haproxy::Helpers.validate_types(@fake_spec, @fake_schema)).to be_falsey
    end
    it 'should return false if type does not match schema type' do
      @fake_spec = {
        'foo' => %w('1' '2')
      }
      expect(Haproxy::Helpers.validate_types(@fake_spec, @fake_schema)).to be_falsey
    end
  end
  describe 'validate_config' do
    before(:each) do
      @fake_schema = {
        'item1' => { type: String, required: true }
      }
    end
    it 'should return false if types invalidate schema' do
      @fake_spec = {
        'item1' => {}
      }
      expect(Haproxy::Helpers.validate_config(@fake_spec, @fake_schema)).to be_falsey
    end
    it 'should return false if a required type is missing' do
      @fake_spec = {
      }
      expect(Haproxy::Helpers.validate_config(@fake_spec, @fake_schema)).to be_falsey
    end
    it 'should return true if all schema requirements are met' do
      @fake_spec = {
        'item1' => 'fubar'
      }
      expect(Haproxy::Helpers.validate_config(@fake_spec, @fake_schema)).to be_truthy
    end
  end
end
