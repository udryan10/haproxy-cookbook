require 'chefspec'
require 'coveralls'

Coveralls.wear!
at_exit { ChefSpec::Coverage.report! }
