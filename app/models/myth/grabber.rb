class Myth::Grabber < ApplicationRecord
  has_many :grabbers_host
  has_many :hosts, through: :grabbers_host
end
