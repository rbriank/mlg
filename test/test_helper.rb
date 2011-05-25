ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def assert_valid(object, field, value)
    object[field] = value
    assert object.valid?
    assert !object.errors[field].any?
  end

  def assert_invalid(object, field, value)
    object[field] = value
    assert !object.valid?
    assert object.errors[field].any?
  end
end
