class UnitAccessRequestNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email, if: :notify_by_email?
  deliver_by :twilio, format: :format_for_twilio, if: :notify_by_twilio?

  param :user

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
