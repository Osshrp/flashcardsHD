class RemoteWordsJob < ActiveJob::Base
  queue_as :default

  def perform(params, user)
    RequestCards.request(params, user)
  end
end
