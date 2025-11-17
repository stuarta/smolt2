class Myth::PlaybackProfile < ApplicationRecord
  has_and_belongs_to_many :playback_profile_details, class_name: "Myth::PlaybackProfileDetail"
end
