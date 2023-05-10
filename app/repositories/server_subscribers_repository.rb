class ServerSubscribersRepository
  def initialize
    @subscribers = YAML.load_file(Rails.root.join('data', 'server_subscribers.yml'))
  end

  def subscribers
    @subscribers
  end
end
