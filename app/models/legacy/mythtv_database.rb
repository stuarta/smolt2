class Legacy::MythtvDatabase < ActiveRecord::Base
  self.table_name = 'mythtv_database'
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
