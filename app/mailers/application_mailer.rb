# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ::EdifyConfig.email_sender_address
  layout "mailer"
end
