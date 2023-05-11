class Server < ApplicationRecord

  validates :hostname, presence: true
  validates :os, presence: true
  validates :ip, presence: true

  after_update -> { ::NotifyServerSubscribersJob.perform_later(self.class, self.attributes, :updated) }
  after_create -> { ::NotifyServerSubscribersJob.perform_later(self.class, self.attributes, :created) }

end
