class LeadsController < BaseController

  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @tip.save
        LeadMailer.with(lead: @lead).thankyou.deliver_now

        format.html { render(partial: "shared/partials/success", locals: { object: @lead }, status: :ok) }
      else
        format.html { render(partial: "shared/partials/errors", locals: { object: @lead }, status: :bad_request) }
      end
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:email)
  end
end
