namespace :notify do
  desc "Notifies users of missing and incomplete meetings"
  task :meetings => :environment do
    puts "Starting MeetingScheduleNotifyJob"
    ::MeetingScheduleNotifyJob.perform_now
    puts "Finished"
  end
end
