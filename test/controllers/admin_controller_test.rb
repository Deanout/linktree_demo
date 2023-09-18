require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get appearance" do
    get admin_appearance_url
    assert_response :success
  end

  test "should get analytics" do
    get admin_analytics_url
    assert_response :success
  end

  test "should get settings" do
    get admin_settings_url
    assert_response :success
  end
end
