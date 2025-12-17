class Core::Device < ApplicationRecord
  has_many :device_links
  has_many :hosts, through: :device_links
  belongs_to :device_bus
  belongs_to :device_class

  def unique_hosts(num_hosts = 20)
    # Unique reports where the host has multiple instances of the same device
    hosts = self.hosts.last(num_hosts).uniq
    # May be multiple reports from the same host
    host_map = {}
    hosts.each do |h|
      host_map[h.host_pub_mapping_id] = h.id # when there's a newer record, only keep that host.id
    end
    hosts.select { |h| host_map.values.include?(h.id) }
  end
end
