class Legacy::HostLink < ActiveRecord::Base
  has_one :host, foreign_key: 'host_link_id'
  has_one :device
end
