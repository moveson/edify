class UserMailer < ApplicationMailer
  def incomplete_meeting_notification
    mail(
      from: "noreply@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: params[:subject],
      )
  end

  def missing_meetings_notification
    mail(
      from: "noreply@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: params[:subject],
      )
  end

  def new_user_admin_notification
    mail(
      from: "noreply@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end

  def new_user_notification
    mail(
      from: "noreply@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end
end
