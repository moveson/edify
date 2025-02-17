class IncompleteMeetingNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email, if: :notify_by_email?
  deliver_by :twilio, format: :format_for_twilio, if: :notify_by_twilio?

  param :meeting

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
    ::I18n.l(meeting.date, format: :month_and_day)
  end
end
