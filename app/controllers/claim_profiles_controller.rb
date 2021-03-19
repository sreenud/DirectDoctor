class ClaimProfilesController < BaseController
  before_action :authenticate_user!
  before_action :set_meta_data, only: [:index]
  before_action :set_claim_profile_request, only: [:update]
  skip_before_action :validate_role

  def show
    @claim_profile_request = ClaimProfileRequest.includes(:claim_profile_comments)
      .where(status: 'follow_up').where(request_token: params[:id])&.first

    @claim_profile_comments = ClaimProfileComment.includes(:user)
      .where(claim_profile_request_id: @claim_profile_request.id)

    1.times { @claim_profile_request.claim_profile_comments.build }

    if @claim_profile_request.present? && @claim_profile_request.profile_name.present?
      doctor_name = @claim_profile_request.profile_name
      @doctor = Doctor.where("name LIKE ?", "%#{doctor_name}%")&.first
    end
  end

  def update
    @claim_profile_request.attributes = claim_profile_request_params
    if @claim_profile_request.save
      message = "Your request is submited successfully. The team will get back to you soon!"
      redirect_to(claim_profile_url(@claim_profile_request.request_token), notice: message)
      # render(json: { message: message, url: claim_profile_url(@claim_profile_request.request_token), success: true })
    else
      render(json: { messages: @claim_profile_request.errors.messages, success: false }, status: :bad_request)
    end
  end

  private

  def set_claim_profile_request
    @claim_profile_request = ClaimProfileRequest.find(params[:id])
    @user = User.find(@claim_profile_request.user_id)
  end

  def set_meta_data
    @allow_robots = false
  end

  def claim_profile_request_params
    params.require(:claim_profile_request).permit(:doctor_id, :user_id,
      claim_profile_comments_attributes: %i[id comment user_id document _destroy])
  end
end
