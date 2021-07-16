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
    practice_style = params[:practice_style]

    @no_directory = true
    if practice_style == "dpc"
      @meta_title ||= "DPC Physician Index - Information about DPC Doctors | Findmydirectdoctor.com"
      @meta_description ||= "DPC Physician Index - Information about DPC Doctors.
        Find a DPC Doctor Online and book appointments instantly! | Findmydirectdoctor.com"
    else
      @meta_title ||= "Concierge Doctors Index - Information about Concierge Physicians | Findmydirectdoctor.com"
      @meta_description ||= " Concierge Doctors Index - Information about Concierge Physicians.
        Find a Concierge Doctor Online and book appointments instantly! | Findmydirectdoctor.com"
    end
  end
end
