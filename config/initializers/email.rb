ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :tls => true,
   :address => "smtp.gmail.com",
   :port =>587, 
   :domain => "rcontract.com",
   :user_name => "murilocadanus@gmail.com",
   :password => "arise000",
   :authentication => :plain
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.default_charset = "UTF-8"
