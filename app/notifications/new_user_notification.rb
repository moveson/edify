class NewUserNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "UserMailer", format: :format_for_email

  param :user

  def format_for_email
    {
      message: message,
      subject: subject,
      url: url,
      user: user,
    }
  end

  def message
    t(".message")
  end

  def subject
    t(".subject")
  end

  def url
    root_url
  end

  def user
    params[:user]
  end
end
