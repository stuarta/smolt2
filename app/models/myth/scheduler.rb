class Myth::Scheduler < ApplicationRecord
  include RecentConcern

  belongs_to :host
end
