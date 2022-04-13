# frozen_string_literal: true

class OnboardPolicy < ApplicationPolicy
  def start?
    user.needs_onboarding?
  end
end
