class Core::Device < ApplicationRecord
  has_many :device_links
  has_many :hosts, through: :device_links
  belongs_to :device_bus
  belongs_to :device_class
end
