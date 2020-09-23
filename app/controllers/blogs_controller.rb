class BlogsController < ApplicationController
  def index
    @categories = Category.includes(:topics)
      .where(topics: { status: 'published' }).active.latest

    @popular_topics = Topic.popular
  end

  def show
    @topic = Topic.find_by_slug(params[:id])

    @popular_topics = Topic.popular
    @other_readings = Topic.where.not(id: @topic.id).limit(5)
  end
end
