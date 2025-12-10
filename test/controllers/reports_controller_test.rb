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

  test "should get view_profile" do
    get reports_view_profile_url, params: { id: 1 }
    assert_response :success
    get reports_view_profile_url, params: { uuid: "11111111-1111-1111-1111-111111111111" }
    assert_response :success
    get reports_view_profile_url, params: { uuid: "pub_11111111-1111-1111-1111-111111111111" }
    assert_response :success
    get reports_view_profile_url, params: { uuid: "1234" }
    assert_match "Host not found", @response.body
    get reports_view_profile_url, params: { uuid: "pub_1234" }
    assert_match "Host not found", @response.body
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
