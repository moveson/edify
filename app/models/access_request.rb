# frozen_string_literal: true

class AccessRequest < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  validates :user_id, uniqueness: { scope: :unit_id }

  def pending?
    status == :pending
  end

  def status
    if rejected_at?
      :rejected
    elsif user.approved_at?
      :approved
    else
      :pending
    end
  end
end
