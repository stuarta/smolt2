class Legacy::HostLink < ActiveRecord::Base
  belongs_to :host, class_name: "Legacy::Host", foreign_key: "host_link_id"
  belongs_to :device, class_name: "Core::Device"
end
