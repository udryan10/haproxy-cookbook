# haproxy Cookbook

[![Build Status](https://secure.travis-ci.org/udryan10/haproxy-cookbook.png)](http://travis-ci.org/udryan10/haproxy-cookbook)
[![Coverage Status](https://coveralls.io/repos/github/udryan10/test/badge.svg?branch=master)](https://coveralls.io/github/udryan10/test?branch=master)

Installs and configures haproxy loadbalancer

## Requirements
### Platforms

- centos-7.1

## Attributes

#### frontend
- `node['frontend']['name'] = frontend1` - name of frontend
- `node['frontend']['bind_address'] = '*'` - address to bind this frontend to
- `node['frontend']['bind_port'] = 80` - port to bind this frontend to
- `node['frontend']['backend'] = 'backend1'` - backend to be used by this frontend
- `node['frontend']['ssl'] = false` - ssl? true or false
- `node['frontend']['options'] = []` - array of strings that will be appended as additional options to this frontned

#### backend
- `node['backend']['name'] = 'backend1'`  - name of backend
- `node['backend']['balance_method '] = 'roundrobin'` - load balancing method to use
- `node['backend']['backend_members'] = [{ ip_address: 'www.google.com', port: 80 }]` - array of backend members hashes, defining ip_address and port pairs
- `node['backend']['health_check'] = 'httpchk HEAD / HTTP/1.1'` - health check to execute against the backends
- `node['backend']['options'] = ['reqirep ^Host: Host:\ www.google.com']` - array of strings that will be appended as additional options to this frontend

## Providers
### haproxy_frontend
sets up an haproxy frontend
```
haproxy_frontend 'frontend1' do
  config(
    bind_address: '*',
    bind_port: 80,
    backend: 'backend1',
    ssl: false,
    options: ['compression algo gzip']
  )
end
```
will generate:
```
frontend frontend1
  bind *:80
  use_backend backend1
  compression algo gzip
```

### haproxy_backend
sets up an haproxy backend
```
haproxy_backend 'backend1' do
  config(
    balance_method: 'roundrobin',
    backend_members: [{ ip_address: 1.1.1.1, port: 80 }, { ip_address: 2.2.2.2, port: 80 }],
    health_check: 'httpchk HEAD / HTTP/1.1',
    options: ['option httpclose', 'option  forwardfor']
  )
end
```
will generate:
```
backend backend1
  balance roundrobin
  server backend10 1.1.1.1:80 check fall 3 rise 2
  server backend10 2.2.2.2:80 check fall 3 rise 2
  option httpchk HEAD / HTTP/1.1
  option httpclose
  option  forwardfor
```
## Usage

### haproxy::install
 installs haproxy package
### haproxy::service
 starts and enables haproxy service
### haproxy::default

Just include `haproxy::default` in your node's `run_list`:

```json
{
  "name":"example",
  "run_list": [
    "recipe[haproxy::default]"
  ]
}
```

### Chefspec

3 custom matchers have been defined for testing haproxy_{frontend,backend,defaults} resources:
  - define_haproxy_frontend
  - define_haproxy_backend
  - define_haproxy_defaults
```
it 'should define haproxy frontend' do
  expect(chef_run).to define_haproxy_frontend('frontend1')
end

it 'should define haproxy backend' do
  expect(chef_run).to define_haproxy_backend('backend1')
end

it 'should define haproxy defaults' do
  expect(chef_run).to define_haproxy_defaults('')
end
```
