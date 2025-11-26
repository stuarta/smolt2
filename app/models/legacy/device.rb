class Legacy::Device < LegacyRecord
  # This is here to document the class, but will fail to
  # work due to the presence of a column named 'class'
  # in the database
  self.table_name = "device"

  has_one :device_class
  belongs_to :host_link
end
