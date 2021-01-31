class DoctorsController < BaseController
  before_action :set_doctor, only: [:show]
  before_action :set_meta_data, only: [:show]

  def show
    @review = Review.new
    @reviews = @doctor&.reviews&.published
  end

  private

  def set_doctor
    @doctor = Doctor.find_by_fdd_id(params[:fdd_id]&.upcase)
  end

  def set_meta_data
    @meta_title ||= "Dr.#{@doctor&.name} -  Book Appointment, View Fees, Contact Number,
      Reviews | #{@doctor&.speciality&.name} in #{@doctor&.state} | FMDD"

    @meta_description ||= "Dr.#{@doctor&.name} is a  #{@doctor&.speciality&.name} in #{@doctor&.city} #{@doctor&.state}.
      Consult Dr.#{@doctor&.name} Online, Book Appointment, View Doctor Fees, Contact Number, User Reviews and Ratings
      for, Dr.#{@doctor&.name} | FMDD"

    @allow_robots = false
  end
end
