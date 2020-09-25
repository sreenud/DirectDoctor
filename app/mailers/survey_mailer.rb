class SurveyMailer < ApplicationMailer
  def thankyou
    @survey = params[:survey]

    mail(to: @survey.email, subject: "Thank you!")
  end
end
