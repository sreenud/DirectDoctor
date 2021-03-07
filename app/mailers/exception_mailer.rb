class ExceptionMailer < ApplicationMailer

  def send_error_details(params_data)
    @params_data = params_data
    @time = Time.now.strftime("%d-%m-%Y %H:%M:%S %Z")
    # rubocop:disable Layout/LineLength
    @subject = "#{@params_data[:controller_name].camelize} - #{@params_data[:status_code]} error raised in FindMyDirectDoctor #{Rails.env.capitalize}"
    mail(to: 'srinivasavarma.d@gmail.com', subject: @subject)
  end
end
