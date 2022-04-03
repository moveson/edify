class Talk < ApplicationRecord
  belongs_to :meeting
  belongs_to :member, optional: true

  validates_presence_of :meeting, :speaker_name

  strip_attributes

  scope :most_recent_first, -> { joins(:meeting).order(date: :desc) }

  before_save :match_member

  delegate :date, :date?, to: :meeting, allow_nil: true

  def member_name
    member&.name
  end

  def topic_truncated
    return unless topic.present?
    return topic if topic.length <= 50

    "#{topic.first(50)}..."
  end

  private

  def match_member
    self.member_id = ::Member.where(name: speaker_name).first&.id
  end
end
