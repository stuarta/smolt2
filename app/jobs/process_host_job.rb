class ProcessHostJob < ApplicationJob
  queue_as :default

  def perform(host_submission)
    hostp = Processor::HostProcessor.new
    host = hostp.process_host(host_submission.data)
    Rails.logger.info "Finished processing host uuid: #{host.uuid}, public: #{host.pub_uuid}"
    host_submission.added = true
    host_submission.save
  end
end
