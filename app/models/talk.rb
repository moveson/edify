# frozen_string_literal: true

class Talk < ApplicationRecord
  DEFAULT_PURPOSE_LIST = [
    "Calling Change",
    "Departing College Student",
    "Departing Missionary",
    "New Ward Member",
    "Returning Missionary",
    "Stake Representative",
    "Ward Conference",
    "Youth Speaker",
  ].freeze

  belongs_to :meeting
  belongs_to :member, optional: true
  acts_as_list scope: :meeting

  validates :speaker_name, presence: true

  strip_attributes

  scope :most_recent_first, -> { joins(:meeting).order(date: :desc) }

  before_save :match_member

  delegate :date, :date?, to: :meeting, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[purpose speaker_name topic]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end

  def member_name
    member&.name
  end

  def topic_truncated
    return if topic.blank?
    return topic if topic.length <= 50

    "#{topic.first(50)}..."
  end

  def unit_members
    meeting.unit.members
  end

  private

  def match_member
    return if meeting.nil?

    self.member_id = unit_members.where(name: speaker_name).first&.id
  end
end
