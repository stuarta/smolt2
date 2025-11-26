require "test_helper"

class Legacy::ClientControllerTest < ActionDispatch::IntegrationTest
  test "add_json" do
    assert true
  end
  test "delete" do
    post "/client/delete", params: { uuid: "1234" }
    assert_response :accepted
  end
  test "show" do
    get "/client/show", params: { uuid: "1234" }
    assert_response :success
  end
  test "show_by_public_uuid" do
    get "/client/show", params: { uuid: "pub_1234" }
    assert_response :success
  end
  test "pub_uuid_not_found" do
    get "/client/pub_uuid", params: { uuid: "1234" }
    assert_response :not_found
  end
  #  test "pub_uuid" do
  #    get "/client/pub_uuid", params: { uuid: "11111111-1111-1111-1111-111111111111" }
  #    assert_response :success
  #  end
  test "regenerate_pub_uuid" do
    get "/client/regenerate_pub_uuid", params: { uuid: "1234" }
    assert_response :success
  end
end
