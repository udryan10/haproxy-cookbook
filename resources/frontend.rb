include Haproxy::Helpers
# Base Resource
actions :create
default_action :create

def self.config_schema
  {
    'bind_address'  => { type: String, required: true },
    'bind_port'     => { type: Fixnum, required: true },
    'backend'       => { type: String, required: true },
    'ssl'           => { type: [TrueClass, FalseClass], required: false },
    'ssl_cert_file' => { type: String, required: false },
    'options'       => { type: Array, required: false }
  }
end

# attributes
attribute :name, name_attribute: true, kind_of: String, required: true
attribute :config,
          kind_of: Hash,
          callbacks: { 'should be a valid frontend config' => ->(spec) { Haproxy::Helpers.validate_config(spec, config_schema) } }
