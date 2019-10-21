class Legacy::MythtvHistorical < ActiveRecord::Base
  self.table_name = 'mythtv_historical'
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
