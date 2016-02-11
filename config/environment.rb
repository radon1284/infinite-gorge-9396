# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails::Initializer.run do |config|
  config.gem 'will_paginate', :version => '~> 2.3.16'
end

require 'will_paginate'