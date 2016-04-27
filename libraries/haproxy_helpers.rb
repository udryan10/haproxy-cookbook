module Haproxy
  # helper methods to keep things DRY
  module Helpers
    def self.validate_config(spec, config_schema)
      return false unless validate_types(spec, config_schema)
      return false unless validate_required(config_schema)
      true
    end

    def self.validate_types(spec, config_schema)
      spec.each do |key, value|
        return error "unknown parameter #{key}" unless config_schema.include?(key)
        # booleans are either trueclass (true) or falseclass (false). can't use is_a? for comparison
        unless value == true || value == false
          return error "#{key} is not of type #{value[:type]}" unless value.is_a?(config_schema[key][:type])
        else
          return error "#{key} is not a boolean" unless config_schema[key][:type] == [TrueClass, FalseClass]
        end
        config_schema.delete key
      end
    end

    def self.validate_required(config_schema)
      config_schema.each do |key, value|
        return error "required parameter #{key} not defined" if value[:required] == true
      end
    end

    def self.error(msg)
      Chef::Log.error msg
      false
    end
  end
end
