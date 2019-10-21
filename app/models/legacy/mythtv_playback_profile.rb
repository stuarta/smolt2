class Legacy::MythtvPlaybackProfile < ActiveRecord::Base
  self.table_name = 'mythtv_pbp'
  belongs_to :host, foreign_key: "machine_id"
  belongs_to :mythtv_host, foreign_key: "myth_uuid"
end
