class DoctorMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def approved
    @doctor = params[:doctor]

    mail(to: @doctor.email, subject: "Welcome to FindMyDirectDoctor!")
  end

  def need_info
    @doctor = params[:doctor]

    mail(to: @doctor.email, subject: "Welcome to FindMyDirectDoctor! Need one last thing.")
  end

  def rejected
    @doctor = params[:doctor]

    mail(to: @doctor.email, subject: "Account update - FindMyDirectDoctor.com")
  end
end
