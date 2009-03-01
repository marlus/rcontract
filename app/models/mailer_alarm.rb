class MailerAlarm < ActionMailer::Base
  def mail(recipient)
    from        "system@rcontract.com"
    recipients  recipient.email
    subject     "Alarme de vencimento de contrato."
    body        :recipient => recipient
  end
end
