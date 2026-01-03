class Core::Filesystem < ApplicationRecord
  include RecentConcern
  belongs_to :host
end
