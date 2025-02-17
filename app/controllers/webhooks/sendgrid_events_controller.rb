module Webhooks
  class SendgridEventsController < ::ApplicationController
    skip_before_action :verify_authenticity_token, if: :valid_webhook_token?

    def create
      status = :ok
      rows = params.require(:_json)

      rows.each do |row|
        sendgrid_event = SendgridEvent.new(row.permit(*sendgrid_event_params))
        sendgrid_event.event_type = row[:type]

        next if sendgrid_event.save

        Sentry.capture_message("Failed to save SendgridEvent",
                               extra: { sendgrid_event: sendgrid_event, errors: sendgrid_event.errors.full_messages })
        status = :unprocessable_entity
        break
      end

      head status
    rescue ActionController::ParameterMissing => e
      Sentry.capture_message("Sendgrid webhook parameter missing", extra: { error: e })
      head :unprocessable_entity
    end

    private

    def sendgrid_event_params
      [
        :email,
        :timestamp,
        :smtp_id,
        :event,
        :category,
        :sg_event_id,
        :sg_message_id,
        :reason,
        :status,
        :ip,
        :response,
        :useragent,
      ]
    end

    def valid_webhook_token?
      event_webhook = SendGrid::EventWebhook.new

      public_key = EdifyConfig.sendgrid_webhook_verification_key
      ec_public_key = event_webhook.convert_public_key_to_ecdsa(public_key)
      payload = request.body.read
      signature = request.headers[SendGrid::EventWebhookHeader::SIGNATURE]
      timestamp = request.headers[SendGrid::EventWebhookHeader::TIMESTAMP]

      event_webhook.verify_signature(ec_public_key, payload, signature, timestamp)
    end
  end
end
