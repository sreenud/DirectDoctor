class DataController < ApplicationController
  def doctor_names
    @doctors = Doctor.all.map do |doctor|
      {
        "name" => doctor&.name&.to_s,
      }
    end

    respond_to do |format|
      format.json do
        render(json: @doctors.as_json)
      end
    end
  end

  def doctors
    @doctors = Doctor.where("name ILIKE ?", "%#{params[:q]}%").published
    render(layout: false)
  end
end
