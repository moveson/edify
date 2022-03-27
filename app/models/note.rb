# frozen_string_literal: true

class Note < ::ApplicationRecord
  belongs_to :member

  validates_presence_of :member_id, :date, :content

  scope :most_recent_first, -> { order(date: :desc) }
end
