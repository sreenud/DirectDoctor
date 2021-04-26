class SocialConnectsController < ApplicationController
  layout "profile"
  before_action :authenticate_user!

  def index
  end
end
