require "test_helper"

class Core::FormfactorTest < ActiveSupport::TestCase
  test "has formfactor" do
    Core::Formfactor.first
    assert :success
  end
end
