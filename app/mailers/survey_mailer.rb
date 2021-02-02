class SurveyMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def thankyou
    @survey = params[:survey]

    mail(to: @survey.email, subject: "Thank you!")
  end
end
