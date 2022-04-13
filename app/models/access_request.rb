class AccessRequest < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  validates :unit_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :unit_id

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
