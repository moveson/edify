# frozen_string_literal: true

class UnitAccessRejectionNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email
  deliver_by :twilio, format: :format_for_twilio

  param :user

  def format_for_email
    {
      message: message,
      subject: subject,
      url: url,
    }
  end

  def format_for_twilio
    {
      Body: "#{message} #{url}",
      From: Rails.application.credentials.twilio[:phone_number],
      To: recipient.phone
    }
  end

  def message
    t(".message", user_name: params[:user].name)
  end

  def subject
    t(".subject")
  end

  def url
    users_url
  end
end
