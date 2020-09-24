class SurveysController < ApplicationController
  def index
  end

  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.valid?
        format.html { render(partial: "shared/partials/success", locals: { object: @survey }, status: :ok) }
      else
        format.html { render(partial: "shared/partials/errors", locals: { object: @survey }, status: :bad_request) }
      end
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:email, question: {})
  end
end
