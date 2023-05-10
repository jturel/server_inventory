class NotifyServerSubscribersJob < ApplicationJob

  def perform(repo = ServerSubscribersRepository.new)

    repo.subscribers.each do |subscriber|
      Rails.logger.info "notifying #{subscriber}"
    end

  end

end
