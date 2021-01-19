class BlogsController < BaseController
  before_action :set_topic, only: [:show]
  before_action :set_meta_data, only: [:show]

  def index
    @categories = Category.includes(:topics)
      .where(topics: { status: 'published' }).active.latest

    @popular_topics = Topic.popular
    @no_directory = true
  end

  def show
    @popular_topics = Topic.popular
    @other_readings = Topic.where.not(id: @topic.id).limit(5)
  end

  private

  def set_topic
    @topic = Topic.find_by_slug(params[:id])
  end

  def set_meta_data
    @meta_title ||= @topic.meta_title
    @meta_description ||= @topic.meta_description
    @allow_robots ||= @topic.status == 'published' ? true : false
  end
end
