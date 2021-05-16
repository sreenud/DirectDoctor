class SignupMailer < ApplicationMailer
  default from: "FindMyDirectDoctor <support@findmydirectdoctor.com>"

  def thankyou
    @user = params[:user]

    mail(to: @user.email, subject: "Welcome to FindMyDirectDoctor!")
  end

  def patient
    @user = params[:user]

    mail(to: @user.email, subject: "Welcome to FindMyDirectDoctor!")
  end
end
