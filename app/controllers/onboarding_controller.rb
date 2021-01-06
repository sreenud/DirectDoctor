class OnboardingController < BaseController
  before_action :authenticate_user!
  before_action :set_meta_data, only: [:index]
  skip_before_action :validate_role

  def step1
    @claim_profile = ClaimProfileRequest.new
  end

  def create_step1
    @claim_profile = ClaimProfileRequest.new(claim_profile_request_params)
    @claim_profile.user_id = current_user.id
    @claim_profile.status = 'requested'
    respond_to do |format|
      if @claim_profile.save
        user = User.find_by_id(current_user.id)
        if @claim_profile.user_type == 'patient'
          user.remove_role(:guest)
          user.add_role(:patient)
        end
        if @claim_profile.user_type == 'doctor'
          user.remove_role(:guest)
          user.add_role(:doctor)
        end

        format.html { redirect_to onboarding_thankyou_url, notice: 'Thank you for your interest.' }
        format.json { render :show, status: :created, location: @claim_profile }
      else
        format.html do
          render(json: { messages: @claim_profile.errors.messages }, status: :bad_request)
        end
      end
    end
  end

  def thankyou
  end

  private

  def set_meta_data
    @allow_robots = false
  end

  def claim_profile_request_params
    params.require(:claim_profile_request).permit(:user_type, :profile_name, :document)
  end
end
