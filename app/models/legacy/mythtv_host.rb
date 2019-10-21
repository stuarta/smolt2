class Legacy::MythtvHost < ActiveRecord::Base
  self.table_name = 'mythtv_host'
  belongs_to :host, foreign_key: "machine_id"
end
