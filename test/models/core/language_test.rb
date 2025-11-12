require "test_helper"

class Core::LanguageTest < ActiveSupport::TestCase
  test "has language" do
    Core::Language.first
    assert :success
  end
end
