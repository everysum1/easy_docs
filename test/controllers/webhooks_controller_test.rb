require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get webhooks_new_url
    assert_response :success
  end

  test "should get create" do
    get webhooks_create_url
    assert_response :success
  end

end
