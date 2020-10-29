class TipsController < ApplicationController
  before_action :set_tip, only: [:show]
  before_action :set_meta_data, only: [:show]

  def index
    @tips = Tip.includes(topic: :author).published
  end

  def show
    @other_readings = Tip.where.not(id: @tip.id).published.limit(5)
  end

  private

  def set_tip
    @tip = Tip.find_by_code(params[:id])
  end

  def set_meta_data
    @meta_title ||= @tip&.meta_title
    @meta_description ||= @tip&.meta_description
    @allow_robots ||= @tip.status == 'published' ? true : false
  end
end
