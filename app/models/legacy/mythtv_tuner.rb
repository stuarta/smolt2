class Legacy::MythtvTuner < ActiveRecord::Base
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
