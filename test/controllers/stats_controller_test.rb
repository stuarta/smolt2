require "test_helper"

class StatsControllerTest < ActionDispatch::IntegrationTest
  test "should get hosts" do
    get stats_hosts_url
    assert_response :success
  end

  test "should get devices" do
    get stats_devices_url
    assert_response :success
  end
end
