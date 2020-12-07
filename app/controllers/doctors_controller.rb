class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.new
    @doctor.lat = 40.73061
    @doctor.lng = -73.935242
  end
end
