require "csv"

namespace :temp do
  desc "Imports talks from csv format"
  task :import_talks, [:filename, :unit_id] => :environment do |_, args|
    Rails.application.eager_load!

    current_unit = Unit.find(unit_id)
    filename = args[:filename]
    table = CSV.parse(File.read(filename), headers: true)

    table.each do |row|
      row_hash = row.to_hash
      row_hash.transform_keys!(&:underscore)

      meeting = current_unit.meetings.find_or_initialize_by(date: row_hash.delete(:date))
      talk = meeting.talks.new(row_hash)

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

      unless meeting.meeting_type.to_sym == :sacrament
        talk.destroy!
      end
    end

    puts "Finished importing talks"
  end
end
