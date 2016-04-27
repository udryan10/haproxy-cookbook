include Haproxy::Helpers
# Base Resource
actions :create
default_action :create

def self.config_schema
  {
    'balance_method'  => { type: String, required: true },
    'backend_members' => { type: Array, required: true },
    'health_check'    => { type: String, required: true },
    'options'         => { type: Array, required: false }
  }
end

# attributes
attribute :name, name_attribute: true, kind_of: String, required: true
attribute :config,
          kind_of: Hash,
          callbacks: { 'should be a valid frontend config' => ->(spec) { Haproxy::Helpers.validate_config(spec, config_schema) } }
