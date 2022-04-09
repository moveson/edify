class UserMailer < ApplicationMailer
  def new_user_admin_notification
    mail(
      from: "notifications@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: "New user for Edify",
    )
  end

  def new_user_notification
    mail(
      from: "noreply@edifyapp.herokuapp.com",
      to: params[:recipient].email,
      subject: "Welcome to Edify!",
    )
  end
end
