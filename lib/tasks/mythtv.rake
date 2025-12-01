namespace :mythtv do
  # Required tasks
  desc "Migrate pub_uuid mappings"
  task migrate_pubuuid: :environment do
    Legacy::Host.pluck(:uuid, :pub_uuid).each do |h|
      Core::HostPubMapping.find_or_create_by(uuid: h[0], pub_uuid: h[1])
    end
  end
  desc "Import old data"
  task import: :environment do
    jobs = []
    Legacy::BatchQueue.find_each do |lq|
      jobs.append(ImportLegacyHostJob.new(lq))
    end
    jobs.in_groups_of(1000, false) { |j| ActiveJob.perform_all_later(j) }
  end

  # Testing tasks
  desc "Test processing of MythTV log data"
  task pl: :environment do
    # s = Core::Submission.last
    s = Legacy::BatchQueue.first
    d = JSON.parse(s.data)
    m = d["distro_specific"]["mythtv"]
    h = m["features"]["logurgency"]
    Rails.logger.info("#{h.to_json}")
  end
  desc "Show last submission"
  task showl: :environment do
    s = Core::Submission.last
    # s = Legacy::BatchQueue.last
    d = JSON.parse(s.data)
    Rails.logger.info("#{d.to_json}")
  end
  desc "Process first submission"
  task pfs: :environment do
    s = Core::Submission.first
    ProcessHostJob.perform_now(s)
  end
  desc "Process last submission"
  task pls: :environment do
    s = Core::Submission.last
    ProcessHostJob.perform_now(s)
  end
  desc "Show first submission"
  task sfs: :environment do
    s = Core::Submission.last
    d = JSON.parse(s.data)
    m = d["distro_specific"]["mythtv"]
    Rails.logger.info("#{m.to_json}")
  end
  desc "Show old submission by id"
  task :showsid, [ :sid ] => :environment do |t, args|
    s = Legacy::BatchQueue.find(args[:sid])
    d = JSON.parse(s.data)
    Rails.logger.info("#{d.to_json}")
  end
  desc "Process old submission by id"
  task :psid, [ :sid ] => :environment do |t, args|
    s = Legacy::BatchQueue.find(args[:sid])
    Rails.logger.info("Processing record id #{s.id}")
    ImportLegacyHostJob.perform_now(s)
  end
  desc "Process random old submission"
  task prs: :environment do
    s = Legacy::BatchQueue.find(Legacy::BatchQueue.ids.sample)
    Rails.logger.info("Selected record id #{s.id} for processing")
    ImportLegacyHostJob.perform_now(s)
  end
  desc "Process 10 random old submissions"
  task prs10: :environment do
    Legacy::BatchQueue.find(Legacy::BatchQueue.ids.sample(10)).each do |s|
      Rails.logger.info("Selected record id #{s.id} for processing")
      ImportLegacyHostJob.perform_now(s)
    end
  end
  desc "Process first old submission"
  task plfs: :environment do
    s = Legacy::BatchQueue.first
    ImportLegacyHostJob.perform_now(s)
  end
end
