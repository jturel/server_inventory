class Server < ApplicationRecord

  after_update -> { ::NotifyServerSubscribersJob.perform_later(self.class, self.attributes, :updated) }
  after_create -> { ::NotifyServerSubscribersJob.perform_later(self.class, self.attributes, :created) }

end
