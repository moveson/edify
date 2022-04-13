# frozen_string_literal: true

class OnboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  after_action :verify_authorized

  def start
  end

  def request_access
  end

  def new_ward
    @unit = Unit.new
  end

  private

  def authorize_user
    authorize ::OnboardController, policy_class: ::OnboardPolicy
  end
end
