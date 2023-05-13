require 'test_helper'

module Webhooks
  class NotifierTest < ActiveSupport::TestCase
    def setup
      @key = SecureRandom.uuid
      subscribers = [
        OpenStruct.new(url: 'http://localhost:8808/webhooks', key: @key)
      ]
      event = OpenStruct.new(body: { event: 'server.created'} )
      @notifier = Webhooks::Notifier.new(subscribers: subscribers, event: event)
    end

    def test_verify_signature
      # comes pretty close to testing signature verification as a client
      stub_request(:post, "http://localhost:8808/webhooks").to_return do |request|
        signature = request.headers['X-Webhook-Signature']
        assert_equal signature, OpenSSL::HMAC.hexdigest('SHA256', @key, request.body)
      end

      @notifier.notify_subscribers
    end
  end
end
