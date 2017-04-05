require 'test_helper'

class WizardPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get createUser" do
    get wizard_pages_createUser_url
    assert_response :success
  end

  test "should get createCard" do
    get wizard_pages_createCard_url
    assert_response :success
  end

  test "should get transaction" do
    get wizard_pages_transaction_url
    assert_response :success
  end

  test "should get webhook" do
    get wizard_pages_webhook_url
    assert_response :success
  end

end
