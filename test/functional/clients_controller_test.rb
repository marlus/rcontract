require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
ClientsController.request_forgery_protection_options[:secret] = 'test_secret'

class ClientsControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_client
    assert_difference('Client.count') do
      xhr :post, :create, :format => 'ext_json', :client => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_client
    get :show, :id => clients(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => clients(:one).id
    assert_response :success
  end

  def test_should_update_client
    xhr :put, :update, :format => 'ext_json', :id => clients(:one).id, :client => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_client
    assert_difference('Client.count', -1) do
      xhr :delete, :destroy, :id => clients(:one).id
    end

    assert_response :success
  end
end
