class RedirectsController < ApplicationController
  before_action :set_location

  def index
    if @page_redirect.present?
      if @page_redirect.redirect_code == "404"
        raise_route_not_found
      else
        redirect_to(@page_redirect.new, status: @page_redirect.redirect_code)
      end
    end
  end

  private

  def set_location
    @page_redirect = PageRedirect.find_by(old: request.path)
  end
end
