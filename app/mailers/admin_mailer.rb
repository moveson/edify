class AdminMailer < ApplicationMailer
  default from: "notifications@edifyapp.herokuapp.com"

  def new_user_admin_notification
    mail(to: params[:recipient], subject: "New user for Edify")
  end
end
