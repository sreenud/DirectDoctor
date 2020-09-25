# Preview all emails at http://localhost:3000/rails/mailers/survey_mailer
class SurveyMailerPreview < ActionMailer::Preview
  def thankyou
    survey = Survey.new(email: "srinivasavarma.d@gmail.com")
    SurveyMailer.with(survey: survey).thankyou
  end
end
