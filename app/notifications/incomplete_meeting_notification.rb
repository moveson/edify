# frozen_string_literal: true

class IncompleteMeetingNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email
  deliver_by :twilio, format: :format_for_twilio

  param :meeting

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
      To: recipient.phone_number
    }
  end

  def message
    t(".message", meeting_type: meeting.meeting_type.titleize, date: date, count: meeting.talks.size)
  end

  def subject
    t(".subject", date: date)
  end

  def url
    meeting_url(meeting)
  end

  private

  def meeting
    params[:meeting]
  end

  def date
    ::I18n.localize(meeting.date, format: :month_and_day)
  end
end
