class Myth::Tuner < ApplicationRecord
  include RecentConcern
  belongs_to :host
end
