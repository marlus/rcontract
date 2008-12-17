require File.dirname(__FILE__) + '/../test_helper'

# make sure the secret for request forgery protection is set (views will
# explicitly use the form_authenticity_token method which will fail otherwise)
AlarmsController.request_forgery_protection_options[:secret] = 'test_secret'

class AlarmsControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    get :index, :format => 'ext_json'
    assert_response :success
    assert_not_nil assigns(:alarms)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_alarm
    assert_difference('Alarm.count') do
      xhr :post, :create, :format => 'ext_json', :alarm => { }
    end

    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_show_alarm
    get :show, :id => alarms(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => alarms(:one).id
    assert_response :success
  end

  def test_should_update_alarm
    xhr :put, :update, :format => 'ext_json', :id => alarms(:one).id, :alarm => { }
    assert_not_nil flash[:notice]
    assert_response :success
  end

  def test_should_destroy_alarm
    assert_difference('Alarm.count', -1) do
      xhr :delete, :destroy, :id => alarms(:one).id
    end

    assert_response :success
  end
end
