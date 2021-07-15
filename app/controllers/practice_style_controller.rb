class PracticeStyleController < BaseController
  include SchemaHelper
  before_action :set_meta_data, only: [:index]

  def index
    @style_specialties = if params[:practice_style] == "dpc"
      Speciality.dpc
    else
      Speciality.cm
    end

    @states = State.all
    @cities = Location.top.limit(60)

    @breadcrumb_schema = practice_style_bread_crumb_schema(params[:practice_style])
  end

  private

  def set_meta_data
    practice_style = params[:practice_style]&.upcase

    @no_directory = true
    @meta_title ||= "#{practice_style} Physician Index - Information about #{practice_style} Doctors | Findmydirectdoctor.com"
    @meta_description ||= "#{practice_style} Physician Index - Information about #{practice_style} Doctors. Find a #{practice_style} Doctor Online and book appointments instantly! | Findmydirectdoctor.com"
  end
end
