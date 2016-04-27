use_inline_resources

action :create do
  node.default[:haproxy][:frontends][new_resource.name] = new_resource.config
end
