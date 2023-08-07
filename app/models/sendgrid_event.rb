# frozen_string_literal: true

class SendgridEvent < ApplicationRecord
  validates :email, :event, :timestamp, presence: true

  def timestamp=(timestamp)
    if timestamp.is_a?(Numeric)
      super Time.zone.at(timestamp)
    elsif timestamp.respond_to?(:numeric?) && timestamp.numeric?
      super Time.zone.at(timestamp.to_i)
    else
      super timestamp
    end
  end
end
