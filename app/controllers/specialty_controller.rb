class SpecialtyController < BaseController
  include SchemaHelper
  before_action :set_specialty
  before_action :set_meta_data, only: [:index]

  def index
    @states = State.all
    @cities = Location.top.limit(60)
    @style = params[:practice_style]

    @breadcrumb_schema = specialty_bread_crumb_schema(@specialty)
  end

  private

  def set_specialty
    @specialty = Speciality.find_by_code(params[:specialty]&.upcase)
  end

  def set_meta_data
    @no_directory = true

    @meta_title ||= "#{@specialty.name} Specialists - Book Instant Appointment,
      Consult Online, View Fees, Contact Numbers, Feedbacks (111/60 chars) "

    @meta_description ||= "#{@specialty.name} Specialists - Book Doctor Appointment,
      Consult Online, View Doctor Fees, User Reviews, Address and
      Phone Numbers of #{@specialty.name} Specialists | Findmydirectdoctor.com"
  end
end
