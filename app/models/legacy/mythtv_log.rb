class Legacy::MythtvLog < LegacyRecord
  self.table_name = "mythtv_log"
  self.primary_key = "myth_uuid"
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
