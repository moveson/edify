# frozen_string_literal: true

class NewUserAdminNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email
  deliver_by :twilio, format: :format_for_twilio

  param :user

  def format_for_email
    {
      message: message,
      subject: subject,
      url: url,
      user: user,
    }
  end

  def format_for_twilio
    {
      Body: "#{message} #{user.name} (#{user.email})",
      From: Rails.application.credentials.twilio[:phone_number],
      To: recipient.phone
    }
  end

  def message
    t(".message")
  end

  def subject
    t(".subject")
  end

  def url
    root_path
  end

  def user
    params[:user]
  end
end
