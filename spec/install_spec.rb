require 'spec_helper'

describe 'haproxy::install' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs haproxy package' do
    expect(chef_run).to install_package('haproxy')
  end
end
