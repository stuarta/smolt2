require "test_helper"

class Legacy::TokenTest < ActiveSupport::TestCase
  uuid = "1234"
  test "valid_token" do
    g = Legacy::Token.new
    token = g.generate_token(uuid)
    assert g.valid?(uuid, token)
  end
  test "invalid_token" do
    g = Legacy::Token.new
    expired_time = Time.now.strftime("%s").to_i - 120
    str = "#{expired_time}" + "\n" + uuid
    invalid_token = python_xor(Rails.application.credentials.legacy[:CRYPTOPASS], str)
    assert_not g.valid?(uuid, invalid_token)
  end
end
