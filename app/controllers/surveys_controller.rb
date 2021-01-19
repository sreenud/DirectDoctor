class SurveysController < BaseController
  def index
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.survey = survey_params[:question]

    respond_to do |format|
      if @survey.save

        SurveyMailer.with(survey: @survey).thankyou.deliver_later

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
