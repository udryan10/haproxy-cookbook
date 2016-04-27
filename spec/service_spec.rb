require 'spec_helper'

describe 'haproxy::service' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'starts haproxy service' do
    expect(chef_run).to enable_service('haproxy')
  end

  it 'enables haproxy service' do
    expect(chef_run).to start_service('haproxy')
  end
end
