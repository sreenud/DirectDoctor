module Admin
  module Blog
    class TopicsController < Admin::BaseController
      before_action :set_topic, only: [:show, :edit, :update, :destroy, :skills]

      def index
        @topics = Topic.latest
      end

      def show
      end

      def new
        @topic = Topic.new
      end

      def edit
      end

      def create
        @topic = Topic.new(topic_params)

        respond_to do |format|
          if @topic.save
            format.html { redirect_to admin_topics_url, notice: 'Topic was successfully created.' }
            format.json { render :show, status: :created, location: @topic }
          else
            format.html { render(partial: "shared/partials/errors", locals: { object: @topic }, status: :bad_request) }
          end
        end
      end

      def update
        respond_to do |format|
          if @topic.update(topic_params)
            format.html { redirect_to admin_topics_url, notice: 'Topic is successfully updated.' }
            format.json { render :show, status: :ok, location: @topic }
          else
            format.html { render(partial: "shared/partials/errors", locals: { object: @topic }, status: :bad_request) }
          end
        end
      end

      private

      def set_topic
        @topic = Topic.find(params[:id])
      end

      def topic_params
        params.require(:topic).permit(:name, :slug, :summary, :content, :is_popular, :author_id, :image,
          :meta_title, :meta_description, :h1_tag, :status, meta_keywords: [[:name]])
      end
    end
  end
end
