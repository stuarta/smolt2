class Core::DeviceLink < ApplicationRecord
  belongs_to :device
  belongs_to :host
end
