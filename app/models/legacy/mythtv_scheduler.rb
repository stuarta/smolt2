class Legacy::MythtvScheduler < LegacyRecord
  self.table_name = "mythtv_scheduler"
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
