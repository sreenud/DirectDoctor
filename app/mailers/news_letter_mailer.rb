class NewsLetterMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def thankyou
    @news_letter = params[:survey]

    mail(to: @news_letter.email, subject: "Welcome to FindMyDirectDoctor!")
  end
end
