# frozen_string_literal: true

class FetchMembersJob < ApplicationJob
  def perform(username, password)
    result = ::Brigham::ScrapeMembers.perform(username, password)

    result.each do |raw_member_row|
      member = Member.find_or_initialize_by(name: raw_member_row.name, birthdate: raw_member_row.birthdate)
      raw_member_row.gender = raw_member_row.gender.downcase == "f" ? "female" : "male"
      member.assign_attributes(raw_member_row.to_h)
      member.save!
    end
  end
end
