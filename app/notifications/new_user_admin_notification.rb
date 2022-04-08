# frozen_string_literal: true

class NewUserAdminNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", format: :format_for_email

  param :user

  def format_for_email
    {
      user: params[:user],
      message: message,
    }
  end

  def message
    user = params[:user]
    t(".message", user_name: user.name, user_email: user.email)
  end
end
