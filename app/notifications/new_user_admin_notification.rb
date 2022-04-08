# frozen_string_literal: true

class NewUserAdminNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer"

  param :user

  def message
    user = params[:user]
    t(".message", user_name: user.name, user_email: user.email)
  end
end
