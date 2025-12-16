class CleanupSubmissionsJob < ApplicationJob
  queue_as :solid_queue_recurring

  def perform(count)
    Core::Submission.where(added: true).limit(count).delete_all
  end
end
