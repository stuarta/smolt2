require 'test_helper'

class Legacy::TokenControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "token_json_works" do
    get token_json_url, params: { uuid: "cf86e924-c797-41a5-a9fe-857be25979fa" }
    assert_response :success
  end
  test "admin_token_json_works" do
    get admin_token_json_url, params: { uuid: "cf86e924-c797-41a5-a9fe-857be25979fa" }
    assert_response :success
  end
end
