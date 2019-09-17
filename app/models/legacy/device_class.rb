class Legacy::DeviceClass < ActiveRecord::Base
  # This is here to document the class, but will fail to
  # work due to the presence of a column named 'class'
  # in the database
  self.table_name = 'classes'
  self.primary_key = 'class'

  belongs_to :device
end
