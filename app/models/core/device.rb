class Core::Device < ApplicationRecord
  belongs_to :core_device_bus,    class_name: "Core::DeviceBus"
  belongs_to :core_device_class,  class_name: "Core::DeviceClass"
end
