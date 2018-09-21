class ActivitySummaryEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.first do |user|
      puts "inside loop"
      UserMailer.activity_summary_email.deliver_later
    end
    puts "after loop"
    # UserMailer.activity_summary_email.deliver_later
  end
end
