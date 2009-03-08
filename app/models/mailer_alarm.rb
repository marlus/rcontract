class MailerAlarm < ActionMailer::Base
  def mail(user, alarm)
    from        "system@rcontract.com"
    recipients  user.email
    subject     "Alarme de vencimento de contrato."
    body        :user => user, :alarm => alarm
  end
end
