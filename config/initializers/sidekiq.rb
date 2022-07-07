Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = "config/schedule.yml"

    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
  end
end
