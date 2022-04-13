# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  # GET /users
  def index
    authorize ::User

    @users = current_unit.users
    @access_requests = current_unit.access_requests
  end
end
