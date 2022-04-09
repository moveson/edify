# frozen_string_literal: true

class NewUserAdminNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", format: :format_for_email
  deliver_by :twilio, format: :format_for_twilio

  param :user

  def format_for_email
    {
      user: params[:user],
      message: message,
    }
  end

  def format_for_twilio
    {
      Body: "#{message} #{params[:user].name} (#{params[:user].email})",
      From: Rails.application.credentials.twilio[:phone_number],
      To: recipient.phone
    }
  end

  def message
    t(".message")
  end
end
