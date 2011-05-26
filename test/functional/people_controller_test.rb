require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  context "People Controller Test" do
    setup do
      @person = Factory(:person)
    end

    should "get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:people)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    context "POST person" do
      should "create valid person" do
        assert_difference('Person.count') do
          post :create, :person => @person.attributes
        end

        assert_redirected_to person_path(assigns(:person))
      end

      should "not create person with blanks" do
        assert_no_difference('Person.count') do
          post :create, :person => @person.attributes.merge({
            :email => nil, :first_name => nil, :last_name => nil, :address => nil
          })
        end

        assert_template :new
        assert_blanks
      end

      should "not create person with invalid field" do
        assert_no_difference('Person.count') do
          post :create, :person => @person.attributes.merge({
            :email => 'not valid', :phone_number => 'not valid'
          })
        end

        assert_template :new
        assert_invalids
      end
    end

    should "show person" do
      get :show, :id => @person.to_param
      assert_response :success
    end

    should "get edit" do
      get :edit, :id => @person.to_param
      assert_response :success
    end

    context "PUT person" do
      should "update valid person" do
        put :update, :id => @person.to_param, :person => @person.attributes
        assert_redirected_to person_path(assigns(:person))
      end

      should "not update person with blanks" do
        put :update, :id => @person.to_param, :person => @person.attributes.merge({
          :email => nil, :first_name => nil, :last_name => nil, :address => nil
        })
        assert_template :edit
        assert_blanks
      end

      should "not update person with invalid fields" do
        put :update, :id => @person.to_param, :person => @person.attributes.merge({
          :email => 'not valid', :phone_number => 'not valid'
        })
        assert_template :edit
        assert_invalids
      end
    end

    should "destroy person" do
      assert_difference('Person.count', -1) do
        delete :destroy, :id => @person.to_param
      end

      assert_redirected_to people_path
    end

    def assert_blanks
      assert_errors
      assert_tag "li", :content => /First name can't be blank/
      assert_tag "li", :content => /Last name can't be blank/
      assert_tag "li", :content => /Address can't be blank/
      assert_tag "li", :content => /Email can't be blank/
    end

    def assert_invalids
      assert_errors
      assert_tag "li", :content => /Email is invalid/
      assert_tag "li", :content => /Phone number is invalid, must contain at least 7 digits, and only: 0-9\/-()+/
    end

    def assert_errors
      assert_tag "div", :attributes => {:id => "error_explanation"}
    end
  end

  context "When searching" do
    setup do
      @person1 = Factory(:person, :first_name => 'bob', :last_name => 'millet')
      @person2 = Factory(:person, :first_name => 'sue', :last_name => 'bob')
      @person3 = Factory(:person, :first_name => 'not like', :last_name => 'the others')
    end

    should "get index" do
      get :index, :named => 'bob'
      assert_response :success
      assert_not_nil assigns(:people)

      assert_tag "td", :content => /bob/
      assert_tag "td", :content => /millet/
      assert_tag "td", :content => /sue/
      assert_no_tag "td", :content => /not like/
    end
  end
  
end
