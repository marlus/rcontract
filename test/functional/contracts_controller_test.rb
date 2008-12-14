require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
ContractsController.request_forgery_protection_options[:secret] = 'test_secret'

class ContractsControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_contract
    assert_difference('Contract.count') do
      xhr :post, :create, :format => 'ext_json', :contract => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_contract
    get :show, :id => contracts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => contracts(:one).id
    assert_response :success
  end

  def test_should_update_contract
    xhr :put, :update, :format => 'ext_json', :id => contracts(:one).id, :contract => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_contract
    assert_difference('Contract.count', -1) do
      xhr :delete, :destroy, :id => contracts(:one).id
    end

    assert_response :success
  end
end
