class Core::Device < ApplicationRecord
  has_many :device_links
  has_many :hosts, through: :device_links
end
