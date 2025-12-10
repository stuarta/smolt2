require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get recent" do
    get reports_recent_url
    assert_response :success
  end

  test "should get search_profiles" do
    get reports_search_profiles_url
    assert_response :success
  end

  test "should get view_profiles" do
    get reports_view_profiles_url
    assert_response :success
  end

  test "should get search_devices" do
    get reports_search_devices_url
    assert_response :success
  end

  test "should get view_devices" do
    get reports_view_devices_url
    assert_response :success
  end

  test "should get search" do
    get reports_search_url
    assert_response :success
  end
end
