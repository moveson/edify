# frozen_string_literal: true

class OnboardPolicy < ApplicationPolicy
  def start?
    user.unit_id.nil?
  end

  def new_ward?
    user.unit_id.nil?
  end

  def request_access?
    user.unit_id.nil?
  end

  def submit_request?
    request_access?
  end
end
