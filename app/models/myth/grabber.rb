class Myth::Grabber < ApplicationRecord
  has_and_belongs_to_many :hosts
end
