# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :talks, dependent: :nullify
  has_many :notes, dependent: :destroy
  belongs_to :unit

  enum gender: [:male, :female]

  validates_presence_of :name, :gender, :birthdate
  validates_uniqueness_of :name, scope: :birthdate
  validate :validate_age

  strip_attributes

  scope :alphabetized, -> { order(:name) }
  scope :with_last_talk_date, -> do
    from(left_joins(talks: :meeting).select("distinct on (members.id) members.*, meetings.date as last_talk_date").order("members.id, meetings.date desc"), :members)
  end

  after_save_commit :match_talks

  def self.ransackable_attributes(auth_object = nil)
    super | %w(last_talk_date)
  end

  def age
    (Date.current - birthdate).to_i / 365
  end

  def bio
    "#{gender.titleize}, #{age}"
  end

  def last_talk_date
    return attributes["last_talk_date"] if attributes.key?("last_talk_date")

    talks.maximum(:date)
  end

  private

  def match_talks
    talks = Talk.where(speaker_name: name, member_id: nil)
    talks.update_all(member_id: id)
  end

  def validate_age
    if birthdate.present? && birthdate >= 11.years.ago.beginning_of_year.to_date
      errors.add(:birthdate, "member is not old enough")
    end
  end
end
