class Core::Device < ApplicationRecord
  has_many :core_device_links
  has_many :core_hosts, through: :device_links
end
