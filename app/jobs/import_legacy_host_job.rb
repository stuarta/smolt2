class ImportLegacyHostJob < ApplicationJob
  queue_as :default

  def perform(legacy_submission)
    Rails.logger.info("Importing submission for #{legacy_submission.hw_uuid} which arrived #{legacy_submission.arrival}")
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
