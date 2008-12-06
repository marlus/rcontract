require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
PersonTypesController.request_forgery_protection_options[:secret] = 'test_secret'

class PersonTypesControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:person_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_person_type
    assert_difference('PersonType.count') do
      xhr :post, :create, :format => 'ext_json', :person_type => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_person_type
    get :show, :id => person_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => person_types(:one).id
    assert_response :success
  end

  def test_should_update_person_type
    xhr :put, :update, :format => 'ext_json', :id => person_types(:one).id, :person_type => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_person_type
    assert_difference('PersonType.count', -1) do
      xhr :delete, :destroy, :id => person_types(:one).id
    end

    assert_response :success
  end
end
