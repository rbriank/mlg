require 'integration_test_helper'

class PeopleTest < ActionController::IntegrationTest
  context "People" do
    should "see people page but no people" do
      visit '/people'
      assert page.has_content?('Listing people')
      assert page.has_no_content?('//table/tr/td')
    end

    should "add a valid person" do
      visit '/people'
      click_link 'New Person'

      assert page.has_content?('New person')
      form_factory
      click_button 'Create Person'

      assert page.has_content?('Person was successfully created')
      click_link "Back"

      assert page.has_content?('Listing people')
      assert page.has_content?('Joe')
    end

    should "not add an invalid person" do
      visit '/people'
      assert page.has_content?('Listing people')
      assert page.has_no_content?('Billy')

      click_link 'New Person'

      assert page.has_content?('New person')
      form_factory(:first_name => 'Billy', :email => 'invalid email')
      click_button 'Create Person'

      assert page.has_content?('Email is invalid')
      click_link "Back"

      assert page.has_content?('Listing people')
      assert page.has_no_content?('Billy')
    end

    context "update" do
      should "make a valid update" do
        @person = Factory(:person, :first_name => "Ronald")

        visit '/people'
        assert page.has_content?('Listing people')
        assert page.has_content?(@person.first_name)
        
        page.find(:xpath, "//tr[@id='person_#{@person.id}']").click_link('Edit')
        assert page.has_content?('Editing person')
        form_factory(:first_name => 'Richard')
        click_button 'Update Person'
        assert page.has_content?('Person was successfully updated.')

        click_link "Back"
        assert page.has_content?('Listing people')
        assert page.has_content?('Richard')
      end

      should "not make an invalid update" do
        @person = Factory(:person, :first_name => "I am not valid")

        visit '/people'
        assert page.has_content?('Listing people')
        assert page.has_content?(@person.first_name)

        page.find(:xpath, "//tr[@id='person_#{@person.id}']").click_link('Edit')
        assert page.has_content?('Editing person')
        form_factory(:first_name => 'I am valid', :email=> 'not valid')
        click_button 'Update Person'
        assert page.has_content?('Email is invalid')

        click_link "Back"
        assert page.has_content?('Listing people')
        assert page.has_no_content?('I am valid')
      end
    end

    should "delete a person" do
      @person = Factory(:person, :first_name => "Delete Me!")

      visit '/people'
      assert page.has_content?('Listing people')
      assert page.has_content?(@person.first_name)

      page.find(:xpath, "//tr[@id='person_#{@person.id}']").click_link('Destroy')
      assert page.has_no_content?(@person.first_name)
    end
  end

  def form_factory(options={})
    options.reverse_merge!({
      :first_name => 'Joe',
      :last_name => 'Blow',
      :address => '123 Any St.',
      :email => 'joe@home.com'
    })

    fill_in 'First name', :with => options[:first_name]
    fill_in 'Last name', :with => options[:last_name]
    fill_in 'Address', :with => options[:address]
    fill_in 'Email', :with => options[:email]
  end
end