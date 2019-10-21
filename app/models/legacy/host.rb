class Legacy::Host < ActiveRecord::Base
  self.table_name = 'host'

  has_many :file_system
  has_many :host_link
end
