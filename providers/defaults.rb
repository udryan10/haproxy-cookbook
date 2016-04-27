use_inline_resources

# generate default config as array. This will be used in a template inside of config lwrp
action :create do
  node.default['haproxy']['defaults'] = new_resource.config
end
