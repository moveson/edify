class AccessRequest < ApplicationRecord
  ASSIGNABLE_ROLES = Set[*::User.roles.keys].freeze

  belongs_to :user
  belongs_to :unit

  validates :user_id, uniqueness: { scope: :unit_id }
  validate :role_exists_on_approval
  validate :role_is_assignable

  strip_attributes

  after_update :conform_user_attributes

  scope :alphabetical, -> { joins(:user).order(:first_name) }
  scope :unapproved, -> { where(approved_at: nil) }

  def approved?
    status == :approved
  end

  def pending?
    status == :pending
  end

  def rejected?
    status == :rejected
  end

  def status
    if rejected_at?
      :rejected
    elsif approved_at?
      :approved
    else
      :pending
    end
  end

  def unit_name
    unit&.name
  end

  def user_name
    user&.name
  end

  private

  def conform_user_attributes
    return true if user_id.nil?

    ::ConformUserToAccessRequest.perform!(self)
  end

  def role_exists_on_approval
    return if approved_at.nil?

    errors.add(:approved_role, "must exist when access request is approved") if approved_role.blank?
  end

  def role_is_assignable
    return if approved_role.blank?

    errors.add(:approved_role, "cannot be #{approved_role}") unless approved_role.in?(ASSIGNABLE_ROLES)
  end
end
