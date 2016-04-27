require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe package('haproxy') do
  it { should be_installed }
end

describe file('/etc/haproxy/haproxy.cfg') do
  it { should exist }
  it { should contain 'balance roundrobin' }
  it { should contain 'option httpchk HEAD / HTTP/1.1' }
  it { should contain 'www.google.com:80' }
end

describe port(80) do
  it { should be_listening }
  it { should be_listening.on('0.0.0.0').with('tcp') }
end

describe command('curl -v -I http://localhost:80') do
  its(:stdout) { should match(%r{HTTP/1.1 200 OK}) }
end
