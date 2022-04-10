# frozen_string_literal: true

class NewUserNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email

  param :user

  def format_for_email
    {
      message: message,
      subject: subject,
      user: user,
    }
  end

  def message
    t(".message")
  end

  def subject
    t(".subject")
  end

  def user
    params[:user]
  end
end
