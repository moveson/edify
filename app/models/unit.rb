# frozen_string_literal: true

class Unit < ApplicationRecord
  has_many :meetings
  has_many :members
  has_many :users
  has_many :talks, through: :meetings

  def meeting_count
    meetings.count
  end

  def member_count
    members.count
  end

  def talk_count
    talks.count
  end
end
