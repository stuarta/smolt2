class Core::Cpu < ApplicationRecord
  include RecentConcern
  has_many :hosts
end
