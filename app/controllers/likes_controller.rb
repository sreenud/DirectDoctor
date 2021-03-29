class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor

  def create
    @doctor.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to(@doctor) }
      format.js
    end
  end

  def destroy
    @doctor.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to(@doctor) }
      format.js
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end
end
