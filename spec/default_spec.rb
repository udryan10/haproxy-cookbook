require 'spec_helper'

describe 'haproxy::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'includes install recipe' do
    expect(chef_run).to include_recipe('haproxy::install')
  end

  it 'includes service recipe' do
    expect(chef_run).to include_recipe('haproxy::service')
  end

  it 'should define haproxy defaults' do
    expect(chef_run).to define_haproxy_defaults('')
  end

  it 'should define haproxy frotend' do
    expect(chef_run).to define_haproxy_frontend('default')
  end

  it 'should define haproxy backend' do
    expect(chef_run).to define_haproxy_backend('default')
  end

  it 'should create /etc/haproxy/haproxy.cfg from template' do
    expect(chef_run).to create_template('/etc/haproxy/haproxy.cfg')
      .with_mode('0644')
  end

  it 'should notify haproxy service upon change of /etc/haproxy/haproxy.cfg' do
    resource = chef_run.template('/etc/haproxy/haproxy.cfg')
    expect(resource).to notify('service[haproxy]').to(:restart).immediately
  end
end
