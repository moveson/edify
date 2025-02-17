class UserMailer < ApplicationMailer
  def incomplete_meeting_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end

  def missing_meetings_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end

  def new_user_admin_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end

  def new_user_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
    )
  end

  def unit_access_approval_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
      template_name: "unit_access_notification",
    )
  end

  def unit_access_rejection_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
      template_name: "unit_access_notification",
    )
  end

  def unit_access_request_notification
    mail(
      to: params[:recipient].email,
      subject: params[:subject],
      template_name: "unit_access_notification",
    )
  end
end
