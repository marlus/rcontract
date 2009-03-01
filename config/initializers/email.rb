ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :user_name => "",
   :password => "",
   :authentication => :plain
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.default_charset = "UTF-8"