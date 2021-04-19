class PatientMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def deleted
    @patient = params[:patient]
    @deleted_by = params[:by]
    mail(to: "info@findmydirectdoctor.com", subject: "Patient profile is deleted")
  end
end
