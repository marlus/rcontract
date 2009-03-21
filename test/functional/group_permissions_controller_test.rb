require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
GroupPermissionsController.request_forgery_protection_options[:secret] = 'test_secret'

class GroupPermissionsControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:group_permissions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_group_permission
    assert_difference('GroupPermission.count') do
      xhr :post, :create, :format => 'ext_json', :group_permission => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_group_permission
    get :show, :id => group_permissions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => group_permissions(:one).id
    assert_response :success
  end

  def test_should_update_group_permission
    xhr :put, :update, :format => 'ext_json', :id => group_permissions(:one).id, :group_permission => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_group_permission
    assert_difference('GroupPermission.count', -1) do
      xhr :delete, :destroy, :id => group_permissions(:one).id
    end

    assert_response :success
  end
end
