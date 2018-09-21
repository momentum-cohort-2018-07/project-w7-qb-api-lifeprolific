class ActivitySummaryEmailJob < ApplicationJob
  queue_as :default

  def perform(activities)
    puts activities
  end
end
