class Myth::GrabbersHost < ApplicationRecord
  include RecentConcern

  belongs_to :host
  belongs_to :grabber
end
