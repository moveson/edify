class OnboardPolicy < ApplicationPolicy
  def start?
    user.needs_onboarding?
  end
end
