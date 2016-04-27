if defined?(ChefSpec)
  def define_haproxy_frontend(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy_frontend, :create, resource_name)
  end

  def define_haproxy_backend(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy_backend, :create, resource_name)
  end

  def define_haproxy_default(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy_backend, :create, resource_name)
  end
end
