# defaults
default['defaults']['config'] = {
  mode: 'http',
  log: 'global',
  option: [
    'httplog',
    'dontlognull',
    'http-server-close',
    'forwardfor except 127.0.0.0/8',
    'redispatch'
  ],
  retries: 3,
  timeout: [
    'http-request 10s',
    'queue 1m',
    'connect 10s',
    'client 1m',
    'server 1m',
    'http-keep-alive 10s',
    'check 10s'
  ],
  maxconn: 3000
}

# front end
default['frontend'] = {
  bind_address: '*',
  bind_port: 80,
  backend: 'default',
  ssl: false,
  options: []
}

# backend
default['backend'] = {
  balance_method: 'roundrobin',
  backend_members: [{ ip_address: 'www.google.com', port: 80 }],
  health_check: 'httpchk HEAD / HTTP/1.1',
  options: ['reqirep ^Host: Host:\ www.google.com']
}
