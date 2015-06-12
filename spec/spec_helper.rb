$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ac/logger'
require 'byebug'

RSpec.configure do |config|
  config.before :each do
  end

  config.after :each do
  end

  # disable $crux debug flag after each test
  config.after(:each) { $crux = false }
end
