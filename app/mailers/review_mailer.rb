class ReviewMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def approved
    @review = params[:review]

    mail(to: @review.email, subject: "Your review is published | FindMyDirectDoctor")
  end

  def rejected
    @review = params[:review]

    mail(to: @review.email, subject: "Update on your review | FindMyDirectDoctor")
  end
end
