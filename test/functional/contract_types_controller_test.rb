require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
ContractTypesController.request_forgery_protection_options[:secret] = 'test_secret'

class ContractTypesControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:contract_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_contract_type
    assert_difference('ContractType.count') do
      xhr :post, :create, :format => 'ext_json', :contract_type => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_contract_type
    get :show, :id => contract_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => contract_types(:one).id
    assert_response :success
  end

  def test_should_update_contract_type
    xhr :put, :update, :format => 'ext_json', :id => contract_types(:one).id, :contract_type => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_contract_type
    assert_difference('ContractType.count', -1) do
      xhr :delete, :destroy, :id => contract_types(:one).id
    end

    assert_response :success
  end
end
