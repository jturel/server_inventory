require 'test_helper'

class NotifyServerSubscribersTest < ActiveSupport::TestCase

  class DummyModel
  end

  def setup
    @url = 'http://example.com/webhooks'
    @attrs = { "something": "else" }
    @repo = OpenStruct.new(
      subscribers: [
        Webhooks::Subscriber.new(url: @url)
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
