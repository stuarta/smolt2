class Myth::Version < ApplicationRecord
  def version_bucket
    self.version.split(/[-+~]/)[0]
  end
end
