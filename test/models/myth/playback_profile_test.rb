require "test_helper"

class Myth::PlaybackProfileTest < ActiveSupport::TestCase
  test "add profile details" do
    x = Myth::PlaybackProfile.first
    x.playback_profile_details << Myth::PlaybackProfileDetail.find(1)
    x.playback_profile_details << Myth::PlaybackProfileDetail.find(2)
    x.host_id = Myth::Host.first.id
    assert x.save
  end
end
