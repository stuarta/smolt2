class Legacy::MythtvRecording < LegacyRecord
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
