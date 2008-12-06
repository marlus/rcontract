require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
UsersController.request_forgery_protection_options[:secret] = 'test_secret'

class UsersControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user
    assert_difference('User.count') do
      xhr :post, :create, :format => 'ext_json', :user => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_user
    get :show, :id => users(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => users(:one).id
    assert_response :success
  end

  def test_should_update_user
    xhr :put, :update, :format => 'ext_json', :id => users(:one).id, :user => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      xhr :delete, :destroy, :id => users(:one).id
    end

    assert_response :success
  end
end
