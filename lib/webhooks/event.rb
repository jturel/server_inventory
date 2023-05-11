module Webhooks
  class Event

    def initialize(payload:, event:)
      @payload = payload
      @event = event
    end

    def body
      {
        payload: @payload,
        event: @event
      }
    end

  end
end
