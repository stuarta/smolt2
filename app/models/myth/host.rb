class Myth::Host < ApplicationRecord
  belongs_to  :branch
  belongs_to  :language
  belongs_to  :libapi
  belongs_to  :theme
  belongs_to  :timezone
  belongs_to  :country
  belongs_to  :version
  belongs_to  :version_bucket
  belongs_to  :qt_version
  belongs_to  :remote
  belongs_to  :protocol
  belongs_to  :tzoffset
end
