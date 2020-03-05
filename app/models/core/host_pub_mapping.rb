class Core::HostPubMapping < ApplicationRecord
  def create_pub_uuid(uuid)
    # generate new pub uuid
    pub_uuid = 'pub_' + SecureRandom.uuid
    Rails.logger.debug "Generated new pub_uuid (#{pub_uuid}) for uuid (#{uuid})"
    mapping = Core::HostPubMapping.create(uuid: uuid, pub_uuid: pub_uuid)
    # Legacy code updates 1 record in the host table, but we save to new table
    pub_uuid
  end

  def get_pub_uuid(uuid)
    host = Legacy::Host.find_by_uuid(uuid)
    if host.nil?
      Rails.logger.debug "Failed to find existing host"
      # Look for an existing mapping of host -> pub_uuid
      mapping = Core::HostPubMapping.find_by_uuid(uuid)
      if mapping.nil?
        new_pub_uuid = create_pub_uuid(uuid)
      else
        Rails.logger.debug "Found an existing mapping #{mapping["uuid"]} to #{mapping["pub_uuid"]}"
        pub_uuid = mapping["pub_uuid"]
      end
    else
      pub_uuid = host.pub_uuid
    end
    pub_uuid
  end
end
