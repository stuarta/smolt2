class Legacy::Host < ActiveRecord::Base
  self.table_name = 'host'

  has_many :file_system, dependent: :destroy
  has_many :host_link, foreign_key: "host_link_id", dependent: :destroy
end
