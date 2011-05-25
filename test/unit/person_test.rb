require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  context "email validity" do
    setup do
      @person = Factory.create(:person)
    end
    should "invalid email should be flagged" do
      @person.email = 'this is not valid'

      assert !@person.valid?
      assert @person.errors[:email].any?
    end
    should "allow valid email" do
      @person.email = 'me@me.com'
      assert @person.valid?
      assert !@person.errors[:email].any?
    end
  end
end
