class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find_by_fdd_id(params[:fdd_id])

    @review = Review.new
    @reviews = @doctor.reviews.published
  end
end
