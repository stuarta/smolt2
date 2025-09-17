class Core::HostPubMapping < ApplicationRecord
  has_many :hosts
  def create_pub_uuid(uuid)
    # generate new pub uuid
    pub_uuid = 'pub_' + SecureRandom.uuid
    Rails.logger.debug "Generated new pub_uuid (#{pub_uuid}) for uuid (#{uuid})"
    Core::HostPubMapping.create(uuid: uuid, pub_uuid: pub_uuid)
    # Legacy code updates 1 record in the host table, but we save to new table
    pub_uuid
  end

  def get_pub_uuid(uuid)
    mapping = Core::HostPubMapping.find_by_uuid(uuid)
    if mapping.nil?
      Rails.logger.debug "Failed to find existing host"
      pub_uuid = create_pub_uuid(uuid)
    else
      Rails.logger.debug "Found an existing mapping #{mapping["uuid"]} to #{mapping["pub_uuid"]}"
      pub_uuid = mapping["pub_uuid"]
    end
    pub_uuid
  end
end
