require "test_helper"

class ListeAchatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get liste_achats_show_url
    assert_response :success
  end
end
