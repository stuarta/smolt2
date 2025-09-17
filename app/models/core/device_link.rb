class Core::DeviceLink < ApplicationRecord
  belongs_to :core_device
  belongs_to :core_host
end
