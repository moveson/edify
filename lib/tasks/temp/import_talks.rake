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

      meeting.meeting_type = if talk.speaker_name.include?("General") && talk.speaker_name.include?("Conference")
                               :general_conference
                             elsif talk.speaker_name.include?("Stake") && talk.speaker_name.include?("Conference")
                               :stake_conference
                             elsif talk.speaker_name.include?("Ward") && talk.speaker_name.include?("Conference")
                               :ward_conference
                             elsif talk.speaker_name.include?("Fast")
                               :testimony_meeting
                             elsif talk.speaker_name.include?("Primary")
                               :primary_program
                             elsif talk.speaker_name.include?("Music")
                               :musical_testimony
                             else
                               :sacrament_meeting
                             end

      meeting.save!

      if meeting.meeting_type.to_sym.in?([:general_conference, :stake_conference, :testimony_meeting, :primary_program])
        talk.destroy!
      end
    end

    puts "Finished importing talks"
  end
end
