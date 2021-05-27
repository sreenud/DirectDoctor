class NewsLettersController < BaseController
  def index
  end

  def create
    @news_letter = NewsLetter.new(news_letter_params)

    respond_to do |format|
      if @news_letter.save

        NewsLetterMailer.with(survey: @news_letter).thankyou.deliver_now

        format.html { render(partial: "shared/partials/success", locals: { object: @news_letter }, status: :ok) }
      else
        format.html { render(partial: "shared/partials/errors", locals: { object: @news_letter }, status: :bad_request) }
      end
    end
  end

  private

  def news_letter_params
    params.require(:news_letter).permit(:email)
  end
end
