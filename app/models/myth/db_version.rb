class Myth::DbVersion < ApplicationRecord
  has_many :databases

  def short_version
    version.split(".").first(2).join(".")
  end
end
