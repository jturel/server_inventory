require 'test_helper'

class NotifyServerSubscribersTest < ActiveSupport::TestCase

  class DummyModel
  end

  def setup
    @url = 'http://example.com/webhooks'
    @Key = "2ee3506e-e0ce-46d1-a8c8-2de606db6915"
    @attrs = { "something": "else" }
    @repo = OpenStruct.new(
      subscribers: [
        Webhooks::Subscriber.new(url: @url, key: @key)
      ]
    )
  end

  def test_perform
    stub_request(:post, @url).
      with(body: { payload: @attrs, event: 'dummymodel.created'}.to_json).
      to_return(status: 200)

    NotifyServerSubscribersJob.perform_now(DummyModel, @attrs, :created, @repo)
  end

end
