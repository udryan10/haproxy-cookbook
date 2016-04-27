#
# Cookbook Name:: haproxy
# Recipe:: default
#

include_recipe  'haproxy::install'
include_recipe  'haproxy::service'

haproxy_defaults '' do
  config node['defaults']['config']
end

haproxy_frontend 'default' do
  config node['frontend']
end

haproxy_backend 'default' do
  config node['backend']
end

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
    config: node.default[:haproxy]
  )
  notifies :restart, 'service[haproxy]', :immediately
end
