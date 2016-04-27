use_inline_resources

# generate frontend config as array. This will be used in a template inside of config lwrp
action :create do
  node.default[:haproxy][:backends][new_resource.name] = new_resource.config
end
