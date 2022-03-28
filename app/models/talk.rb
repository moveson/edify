class Talk < ApplicationRecord
  belongs_to :meeting, optional: true
  belongs_to :member, optional: true

  validates_presence_of :speaker_name, :date

  strip_attributes

  scope :most_recent_first, -> { order(date: :desc) }

  before_save :match_member

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
