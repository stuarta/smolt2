require "test_helper"

class Core::SubmissionTest < ActiveSupport::TestCase
  test "has submission" do
    Core::Submission.first
    assert :success
  end
end
