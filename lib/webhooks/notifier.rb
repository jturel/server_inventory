module Webhooks
  class Notifier

    def initialize(subscribers:, event:)
      @subscribers = subscribers
      @event = event
    end

    def notify_subscribers
      json = @event.body.to_json

      @subscribers.each do |subscriber|
        Rails.logger.info "notifying #{subscriber.url} #{@event.body[:event]}"

        begin
          request = RestClient::Request.execute(
            method: :post,
            timeout: 5,
            url: subscriber.url,
            payload: json,
            headers: {
              'X-Webhook-Signature' => signature(subscriber.key, json),
              'User-Agent' => 'server_inventory/1.0',
              'Content-type' => Mime[:json]
            }
          )
        rescue => e
          Rails.logger.error("Error while notifying #{subscriber.url} error=#{e.message}")
        end

      end
    end

    private

    def signature(key, payload_string)
      OpenSSL::HMAC.hexdigest("SHA256", key, payload_string)
    end

  end
end
