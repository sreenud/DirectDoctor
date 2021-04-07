# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
# ActionMailer::Base.smtp_settings = {
#   address: "smtp.mailgun.org",
#   port: 587,
#   user_name: Rails.application.credentials.dig(:mailgun, :user_name),
#   password: Rails.application.credentials.dig(:mailgun, :password),
#   domain: "findmydirectdoctor.com",
#   authentication: :plain,
#   enable_starttls_auto: true,
#   perform_deliveries: true,
#   raise_delivery_errors: true,
#   charset: "utf-8",

# }
