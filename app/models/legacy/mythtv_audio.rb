class Legacy::MythtvAudio < ActiveRecord::Base
  self.table_name = 'mythtv_audio'
  belongs_to :host, foreign_key: "machine_id"
end
