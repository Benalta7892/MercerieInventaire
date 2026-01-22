require "test_helper"

class FournituresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fournitures_index_url
    assert_response :success
  end

  test "should get show" do
    get fournitures_show_url
    assert_response :success
  end

  test "should get new" do
    get fournitures_new_url
    assert_response :success
  end

  test "should get create" do
    get fournitures_create_url
    assert_response :success
  end

  test "should get edit" do
    get fournitures_edit_url
    assert_response :success
  end

  test "should get update" do
    get fournitures_update_url
    assert_response :success
  end

  test "should get destroy" do
    get fournitures_destroy_url
    assert_response :success
  end

  test "should get stock_bas" do
    get fournitures_stock_bas_url
    assert_response :success
  end
end
