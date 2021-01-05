class OnboardingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meta_data, only: [:index]
  skip_before_action :validate_role

  def step1
  end

  def create_step1
    user = User.find_by_id(current_user.id)
    if params[:user_type] == 'patient'
      user.remove_role(:guest)
      user.add_role(:patient)
    end
    if params[:user_type] == 'doctor'
      user.remove_role(:guest)
      user.add_role(:doctor)
    end
  end

  private

  def set_meta_data
    @allow_robots = false
  end
end
