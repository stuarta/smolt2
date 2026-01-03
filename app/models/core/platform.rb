class Core::Platform < ApplicationRecord
  include RecentConcern
  has_many :hosts
end
