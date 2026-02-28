class Myth::Storage < ApplicationRecord
  include RecentConcern
  include StorageConcern

  belongs_to :host
end
