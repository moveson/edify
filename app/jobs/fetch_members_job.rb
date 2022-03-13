# frozen_string_literal: true

require "utilities/brigham"

class FetchMembersJob < ApplicationJob
  def perform(username, password, import_job_id)
    import_job = ImportJob.find(import_job_id)
    result = ::Brigham::ScrapeMembers.perform(username, password, import_job)

    result.each do |raw_member_row|
      member = Member.find_or_initialize_by(name: raw_member_row.name, birthdate: raw_member_row.birthdate)
      raw_member_row.gender = raw_member_row.gender.downcase == "f" ? "female" : "male"
      member.assign_attributes(raw_member_row.to_h)
      member.save!
    end
  end
end
