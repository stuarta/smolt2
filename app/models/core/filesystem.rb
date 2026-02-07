class Core::Filesystem < ApplicationRecord
  include FilesystemBucketConcern
  include RecentConcern
  belongs_to :host
end
