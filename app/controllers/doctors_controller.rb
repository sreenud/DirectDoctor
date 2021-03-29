class DoctorsController < BaseController
  before_action :set_doctor, only: [:show]
  before_action :set_meta_data, only: [:show]

  def show
    @review = Review.new
    @reviews = @doctor&.reviews&.published
  end

  private

  def set_doctor
    @doctor = Doctor.published.where(fdd_id: params[:fdd_id]&.upcase)&.first
  end

  def set_meta_data
    @meta_title ||= "#{@doctor&.name}, #{@doctor&.doctor_title} -
      Book Appointment, View Fees, Contact Number,
      Reviews | #{@doctor&.speciality&.name} in #{@doctor&.state} | FMDD"

    @meta_description ||= "#{@doctor&.name}, #{@doctor&.doctor_title} is a
      #{@doctor&.speciality&.name} in #{@doctor&.city} #{@doctor&.state}.
      Consult #{@doctor&.name}, #{@doctor&.doctor_title}
      Online, Book Appointment, View Doctor Fees, Contact Number, User Reviews and Ratings
      for, #{@doctor&.name}, #{@doctor&.doctor_title} | FMDD"

    @allow_robots = false
  end
end
