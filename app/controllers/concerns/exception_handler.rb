

module ExceptionHandler
  extend ActiveSupport::Concern

  #  Custom exception define methods
  def raise_route_not_found
    raise ActionController::RoutingError, "Not Found"
  end

  def raise_record_not_found
    raise ActiveRecord::RecordNotFound, "Invalid Record"
  end

  def raise_invalid_record
    raise ActiveRecord::RecordInvalid, "Invalid Record"
  end

  # Custom exception handler methods
  included do
    unless Rails.application.config.consider_all_requests_local
      rescue_from StandardError do |exception|
        record_not_found(exception)
      end
      rescue_from(ActiveRecord::RecordInvalid, with: :record_not_found)
      rescue_from(ActiveRecord::RecordNotFound, with: :record_not_found)
      rescue_from(ActionController::RoutingError, with: :route_not_found)
      # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    end
  end

  private

  def user_not_authorized(exception)
    meta_info("401 - UnAuthorized")
    render_page(401)
    error_email_notification(exception, 401)
  end

  def route_not_found(_exception)
    meta_info("Page Not Found")
    store_404_details(request)
    render_page(404)
  end

  def record_not_found(exception)
    meta_info("500 Internal Server Error")
    render_page(500)
    error_email_notification(exception, 500)
  end

  def render_page(code)
    @index = false
    render("errors/error_#{code}", status: code, layout: "application")
  end

  def error_email_notification(exception, status_code)
    ExceptionMailer.send_error_details(
      exception: exception,
      request: request,
      user: current_user,
      controller_name: controller_name,
      params: params,
      location: "N/A",
      browser: "N/A",
      status_code: status_code || 404
    ).deliver
  end

  def store_404_details(request)
    path = "#{Rails.public_path}/system/error_404_logs"
    file_name = "error_404_#{Date.today.strftime("%d_%m_%Y")}.txt"
    FileUtils.mkdir_p(path)
    File.open("#{path}/#{file_name}", "a+") do |f|
      f.puts "-----------*************--------------"
      f.puts ""
      f.puts "URL: #{request.base_url}/#{request.fullpath}"
      f.puts "Request Method: #{request.headers["REQUEST_METHOD"]}"
      f.puts "Request Type: #{request.xhr? ? "AJAX" : ""}"
      f.puts "IP Address: #{request.ip}"
      f.puts "Referer: #{request.referer}"
      f.puts "Location: #{session[:loc_country]}, #{session[:loc_city]} - #{session[:loc_timezone]}"
      f.puts "Time: #{Time.now.strftime("%d-%b-%Y %H:%M:%S %p %Z")}"
      f.puts ""
    end
  end

  def meta_info(title)
    @meta_title = title
    @meta_description = ""
    @meta_keywords = ""
  end
end
