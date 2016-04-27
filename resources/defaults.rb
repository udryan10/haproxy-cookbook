include Haproxy::Helpers
# Base Resource
actions :create
default_action :create

def self.config_schema
  {
    'mode'    => { type: String, required: false },
    'log'     => { type: String, required: false },
    'option'  => { type: Array, required: false },
    'retries' => { type: Fixnum, required: false },
    'timeout' => { type: Array, required: false },
    'maxconn' => { type: Fixnum, required: false }
  }
end

# attributes
attribute :config,
          kind_of: Hash,
          callbacks: { 'should be a valid defaults config' => ->(spec) { Haproxy::Helpers.validate_config(spec, config_schema) } }
