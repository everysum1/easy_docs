require 'test_helper'

class CardProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get card_products_new_url
    assert_response :success
  end

  test "should get create" do
    get card_products_create_url
    assert_response :success
  end

end
