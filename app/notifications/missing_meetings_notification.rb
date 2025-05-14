class MissingMeetingsNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email, if: :notify_by_email?
  deliver_by :twilio, format: :format_for_twilio, if: :notify_by_twilio?

  param :dates

  def message
    t(".message", date_string: date_string, count: params[:dates].size)
  end

  def subject
    t(".subject")
  end

  def url
    meetings_url
  end

  def date_string
    params[:dates].map { |date| ::I18n.l(date, format: :month_and_day) }.to_sentence
  end
end
