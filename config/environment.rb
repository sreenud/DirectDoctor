# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  address: "email-smtp.us-east-2.amazonaws.com",
  port: 587,
  user_name: Rails.application.credentials.dig(:ses, :user_name),
  password: Rails.application.credentials.dig(:ses, :password),
  domain: "www.findmydirectdoctor.com",
  authentication: :login,
  enable_starttls_auto: true,
  perform_deliveries: true,
  raise_delivery_errors: true,
  charset: "utf-8",

}
