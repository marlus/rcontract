scheduler = Rufus::Scheduler.start_new  
   
# Send the digest every day at noon  
scheduler.cron("* * * * *") do
  MailerAlarm.deliver_mail("murilocadanus@rcontract.com")
end