class Myth::Audio < ApplicationRecord
  include RecentConcern

  belongs_to :host
end
