class ImportLegacyHostJob < ApplicationJob
  queue_as :default

  def perform(legacy_submission)
    if legacy_submission.data.length > 65535
      Rails.logger.info("Submission id: #{legacy_submission.id} is too large. Skipping")
      return false
    end
    Rails.logger.info("Importing submission id: #{legacy_submission.id}, hw_uuid: #{legacy_submission.hw_uuid} which arrived #{legacy_submission.arrival}")
    host = Legacy::Host.find_by(uuid: legacy_submission.hw_uuid)
    Core::HostPubMapping.find_or_create_by(uuid: host["uuid"], pub_uuid: host["pub_uuid"])
    s = Core::Submission.create(
      added: false,
      arrival: legacy_submission.arrival,
      hw_uuid: legacy_submission.hw_uuid,
      data: legacy_submission.data
    )
    ProcessHostJob.perform_later(s)
    true
  end
end
