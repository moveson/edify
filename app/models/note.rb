# frozen_string_literal: true

class Note < ::ApplicationRecord
  belongs_to :member

  validates :date, :content, presence: true

  scope :most_recent_first, -> { order(date: :desc) }
end
