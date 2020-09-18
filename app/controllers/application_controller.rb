class ApplicationController < ActionController::Base
  before_action :menu_details, only: %i[index show], unless: proc { request.xhr? }

  private

  def menu_details
    menu_blog_categories
  end

  def menu_blog_categories
    @menu_categories = Category.latest.limit(5)
  end
end
