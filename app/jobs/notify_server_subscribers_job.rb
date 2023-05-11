class NotifyServerSubscribersJob < ApplicationJob

  def perform(model_class, attributes, event, repo = ServerSubscribersRepository.new)
    event = Webhooks::Event.new(
      payload: attributes,
      event: "#{model_class.name.demodulize.downcase}.#{event}"
    )

    notifier = Webhooks::Notifier.new(
      subscribers: repo.subscribers,
      event: event
    )

    notifier.notify_subscribers
  end

end
