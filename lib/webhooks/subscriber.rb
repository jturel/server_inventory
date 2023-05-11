module Webhooks
  class Subscriber

    attr_reader :url

    def initialize(url:)
      @url = url
    end

  end
end
