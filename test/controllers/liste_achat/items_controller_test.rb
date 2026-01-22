require "test_helper"

class ListeAchat::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get liste_achat_items_create_url
    assert_response :success
  end

  test "should get destroy" do
    get liste_achat_items_destroy_url
    assert_response :success
  end
end
