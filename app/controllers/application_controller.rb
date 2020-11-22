class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :menu_details, only: %i[index show], unless: proc { request.xhr? }

  def load_gmap
    @load_gmaps = true
  end

  private

  def menu_details
    menu_blog_categories
  end

  def menu_blog_categories
    @menu_categories = Category.latest.limit(5)
  end
end
