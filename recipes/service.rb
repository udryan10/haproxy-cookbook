#
# Cookbook Name:: haproxy
# Recipe:: service
#

service 'haproxy' do
  action [:start, :enable]
end
