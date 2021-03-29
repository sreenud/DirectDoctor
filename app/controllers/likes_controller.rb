class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor

  def create
    @doctor.likes.where(user_id: current_user.id).first_or_create

    render(json: {success: true})
  end

  def destroy
    @doctor.likes.where(user_id: current_user.id).destroy_all

    render(json: {success: true})
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end
end
