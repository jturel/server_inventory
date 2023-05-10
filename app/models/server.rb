class Server < ApplicationRecord

  after_update -> { ::NotifyServerSubscribersJob.perform_later }
  after_create -> { ::NotifyServerSubscribersJob.perform_later }

end
