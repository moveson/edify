# frozen_string_literal: true

class MissingMeetingsNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email
  deliver_by :twilio, format: :format_for_twilio

  param :dates

  def format_for_email
    {
      message: message,
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
    t(".message", date_string: date_string, count: params[:dates].size)
  end

  def url
    meetings_url
  end

  def date_string
    params[:dates].map { |date| ::I18n.l(date, format: :month_and_day) }.to_sentence
  end
end
