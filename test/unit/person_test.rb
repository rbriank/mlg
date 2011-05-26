require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  context "attribute validity" do
    setup do
      @person = Factory(:person)
    end

    context "email validity" do
      should "flag invalid" do
        assert_invalid(@person, :email, 'this is not valid')
        assert_invalid(@person, :email, nil)
      end
      should "allow valid" do
        assert_valid(@person, :email, 'me@me.com')
      end
    end

    context "phone number validity" do
      should "flag invalid" do
        assert_invalid(@person, :phone_number, 'this is not valid')
        assert_invalid(@person, :phone_number, '1234')
      end
      should "allow valid" do
        assert_valid(@person, :phone_number, '(555) 555-1212')
        assert_valid(@person, :phone_number, '555-1212')
      end
      should "not be required" do
        assert_valid(@person, :phone_number, nil)
      end
    end

    [:first_name, :last_name, :address].each do |field|
      context "#{field} present" do
        should "flag invalid" do
          assert_invalid(@person, field, nil)
          assert_invalid(@person, field, '')
        end
        should "allow valid" do
          assert_valid(@person, field, 'anything is better than nothing')
        end
      end
    end
  end

  context "verification" do
    setup do
      @person = Factory(:person, :verified => false)
    end

    should "update person with verify" do
      assert @person.verify
      @person.reload
      assert @person.verified
    end
  end

  context "scopes" do
    setup do
      @person1 = Factory(:person, :first_name => 'bob', :last_name => 'millet')
      @person2 = Factory(:person, :first_name => 'sue', :last_name => 'bob')
      @person3 = Factory(:person, :first_name => 'not like', :last_name => 'the others')
    end

    should "find people by first or last name" do
      people_ids = Person.named('bob').map(&:id)
      assert people_ids.include?(@person1.id)
      assert people_ids.include?(@person2.id)
      assert !people_ids.include?(@person3.id)
    end

    should "not find people who aren't there" do
      people_ids = Person.named('not here').map(&:id)
      assert people_ids.empty?
    end
  end

  context "Queuing jobs" do
    setup do
      @person = Factory(:person)
    end

    should "Queue a verify job" do
      assert_queued(VerifyJob, [@person.id])
    end

    should "run jobs" do
      assert !@person.verified
      Resque.run!
      @person.reload
      assert @person.verified
    end
  end
end
