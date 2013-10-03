ENV["RAILS_ENV"] ||= "test"
if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'wrong/adapters/minitest'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Personalization
end
