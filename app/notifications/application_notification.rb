class ApplicationNotification < Noticed::Base
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

  private

  def notify_by_email?
    recipient.notification_preference_email?
  end

  def notify_by_twilio?
    recipient.notification_preference_sms?
  end

  def message
    raise NotImplementedError, "Notification must implement #message"
  end

  def subject
    raise NotImplementedError, "Notification must implement #subject"
  end

  def url
    raise NotImplementedError, "Notification must implement #url"
  end
end
