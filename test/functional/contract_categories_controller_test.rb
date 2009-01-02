require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
ContractCategoriesController.request_forgery_protection_options[:secret] = 'test_secret'

class ContractCategoriesControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:contract_categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_contract_category
    assert_difference('ContractCategory.count') do
      xhr :post, :create, :format => 'ext_json', :contract_category => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_contract_category
    get :show, :id => contract_categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => contract_categories(:one).id
    assert_response :success
  end

  def test_should_update_contract_category
    xhr :put, :update, :format => 'ext_json', :id => contract_categories(:one).id, :contract_category => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_contract_category
    assert_difference('ContractCategory.count', -1) do
      xhr :delete, :destroy, :id => contract_categories(:one).id
    end

    assert_response :success
  end
end
