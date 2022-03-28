require "csv"

namespace :temp do
  desc "Imports talks from csv format"
  task :create_meetings_from_talks => :environment do |_, args|
    Rails.application.eager_load!

    Talk.find_each do |talk|
      meeting = Meeting.find_or_initialize_by(date: talk.date)
      if talk.speaker_name.include?("General") && talk.speaker_name.include?("Conference")
        meeting.meeting_type = :general_conference
      elsif talk.speaker_name.include?("Stake") && talk.speaker_name.include?("Conference")
        meeting.meeting_type = :stake_conference
      elsif talk.speaker_name.include?("Ward") && talk.speaker_name.include?("Conference")
        meeting.meeting_type = :ward_conference
      elsif talk.speaker_name.include?("Fast")
        meeting.meeting_type = :testimony
      elsif talk.speaker_name.include?("Primary")
        meeting.meeting_type = :primary_program
      elsif talk.speaker_name.include?("Music")
        meeting.meeting_type = :musical_testimony
      else
        meeting.meeting_type = :sacrament
      end

      meeting.save!
      talk.update(meeting: meeting)
    end

    puts "Finished creating meetings"
  end
end
