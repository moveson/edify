# frozen_string_literal: true

class OnboardController < ApplicationController
  before_action :authenticate_user!

  def start
  end

  def request_access
  end

  def new_ward
  end
end
