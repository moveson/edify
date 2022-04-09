# frozen_string_literal: true

class NewUserNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email

  param :user

  def format_for_email
    {
      user: params[:user],
      message: message,
    }
  end

  def message
    t(".message")
  end
end
