class DoctorMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def approved
    @doctor = params[:doctor]

    mail(to: @doctor.email, subject: "Welcome to FindMyDirectDoctor!")
  end

  def need_info
    @claim_profile_request = params[:claim_profile_request]
    email = @claim_profile_request&.user&.email
    @comment = @claim_profile_request&.claim_profile_comments&.last&.comment
    @request_info_url = claim_profile_url(@claim_profile_request.request_token)

    mail(to: email, subject: "Welcome to FindMyDirectDoctor! Need one last thing.")
  end

  def rejected
    @claim_profile_request = params[:claim_profile_request]
    email = @claim_profile_request&.user&.email
    @comment = @claim_profile_request&.claim_profile_comments&.last&.comment

    mail(to: email, subject: "Account update - FindMyDirectDoctor.com")
  end

  def deleted
    @doctor = params[:doctor]
    @deleted_by = params[:by]
    mail(to: "info@findmydirectdoctor.com", subject: "Doctor profile is deleted")
  end
end
