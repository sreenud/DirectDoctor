class LeadMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def thankyou
    @lead = params[:lead]

    mail(to: @lead.email, subject: "Thank you!")
  end
end
