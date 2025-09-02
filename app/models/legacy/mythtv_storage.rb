class Legacy::MythtvStorage < LegacyRecord
  self.table_name = 'mythtv_storage'
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
