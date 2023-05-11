module Webhooks
  class Subscriber

    attr_reader :url, :key

    def initialize(url:, key:)
      @url = url
      @key = key
    end

  end
end
