class Myth::Host < ApplicationRecord
  belongs_to  :uuid

  belongs_to  :branch
  belongs_to  :country
  belongs_to  :language
  belongs_to  :libapi
  belongs_to  :protocol
  belongs_to  :qt_version
  belongs_to  :remote
  belongs_to  :theme
  belongs_to  :timezone
  belongs_to  :tzoffset
  belongs_to  :version
  belongs_to  :version_bucket

  has_and_belongs_to_many :grabbers

  has_many :recordings, dependent: :destroy
  has_many :storages, dependent: :destroy
  has_many :tuners, dependent: :destroy

  has_one :audio, dependent: :destroy
  has_one :database, dependent: :destroy
  has_one :historical, dependent: :destroy
  has_one :playback_profile, dependent: :destroy
  has_one :scheduler, dependent: :destroy
end
