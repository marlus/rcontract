require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
GroupsController.request_forgery_protection_options[:secret] = 'test_secret'

class GroupsControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_group
    assert_difference('Group.count') do
      xhr :post, :create, :format => 'ext_json', :group => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_group
    get :show, :id => groups(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => groups(:one).id
    assert_response :success
  end

  def test_should_update_group
    xhr :put, :update, :format => 'ext_json', :id => groups(:one).id, :group => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_group
    assert_difference('Group.count', -1) do
      xhr :delete, :destroy, :id => groups(:one).id
    end

    assert_response :success
  end
end
