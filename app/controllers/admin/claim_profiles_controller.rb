module Admin
  class ClaimProfilesController < Admin::BaseController
    before_action :set_claim_profile_request, only: [:show, :edit, :update, :destroy]

    def show
      set_fdd_profile

      @claim_profile_request.name = @user.full_name
      @claim_profile_request.email = @user.email
      @specialities = Speciality.latest
      @states = State.by_name
      1.times { @claim_profile_request.claim_profile_comments.build }
      @claim_profile_comments = cliam_profile_comments
      update_claim_profile_comments_read_status
    end

    def update
      @claim_profile_request.attributes = claim_profile_request_params

      if @claim_profile_request.save
        if @claim_profile_request.status == "approve"
          doctor = create_or_find(claim_profile_request_params)

          doctor.user_id = claim_profile_request_params[:user_id]
          doctor.status = 'published'
          doctor.save(validate: false)

          DoctorMailer.with(doctor: doctor).approved.deliver_now
          message = "Profile is approved"
          redirect_to(admin_claim_profile_url(@claim_profile_request), notice: message)
        elsif @claim_profile_request.status == 'follow_up'
          message = "Request is sent to provider for more details"

          DoctorMailer.with(claim_profile_request: @claim_profile_request).need_info.deliver_now
          render(json: {
            html: render_to_string(partial: 'admin/claim_profiles/comments.html.erb',
              locals: {
                claim_profile_comments: cliam_profile_comments,
              }),
            message: message,
            url: admin_dashboard_index_url,
            success: true,
          })
        else
          DoctorMailer.with(claim_profile_request: @claim_profile_request).rejected.deliver_now
          message = "Profile is rejected"
          redirect_to(admin_claim_profile_url(@claim_profile_request), alert: message)
        end
      else
        render(json: { message: @claim_profile_request.errors.messages, success: false }, status: :bad_request)
      end
    end

    def destroy
      @state = ClaimProfileRequest.find(params[:id])
      @state.destroy

      redirect_to(admin_dashboard_index_url)
    end

    private

    def update_claim_profile_comments_read_status
      comment_ids = ClaimProfileComment.where(claim_profile_request_id: @claim_profile_request.id).pluck(:id)
      ClaimProfileComment.where(id: comment_ids).update_all(is_read: true)
    end

    def create_or_find(claim_profile_request_params)
      if claim_profile_request_params[:doctor_id].present?
        Doctor.find_by_id(claim_profile_request_params[:doctor_id])
      else
        user = User.find_by_id(@claim_profile_request.user_id)
        doctor = Doctor.new(
          user_id: user.id,
          name: user.full_name,
          email: user.email,
          profile_source: 'cliam_profile'
        )
        doctor.save(validate: false)
        doctor
      end
    end

    def cliam_profile_comments
      ClaimProfileComment.includes(:user)
        .where(claim_profile_request_id: @claim_profile_request.id)
    end

    def set_claim_profile_request
      @claim_profile_request = ClaimProfileRequest.find(params[:id])
      @user = User.find(@claim_profile_request.user_id)
    end

    def set_fdd_profile
      doctor_name = @claim_profile_request&.doctor_name
      if doctor_name
        @doctor = Doctor.where("name LIKE ?", "%#{doctor_name}%")&.first
      end
    end

    def claim_profile_request_params
      params.require(:claim_profile_request).permit(:id, :name, :user_id, :email,
        :doctor_id, :user_id, :status, claim_profile_comments_attributes: %i[id comment user_id _destroy])
    end
  end
end
