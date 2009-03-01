class MailerAlarm < ActionMailer::Base
  def mail(recipient)
    from        "sender.address@example.com"
    recipients  recipient
    subject     "Hi #{recipient}"
    body        :recipient => recipient
  end
end
