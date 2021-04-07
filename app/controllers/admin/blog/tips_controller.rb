module Admin
  module Blog
    class TipsController < Admin::BaseController
      before_action :set_tip, only: [:show, :edit, :update, :destroy]

      def index
        @q = Tip.ransack(params[:q])
        @tips = @q.result.latest

        @pagy, @tips = pagy(@tips)
      end

      def show
      end

      def new
        @tip = Tip.new
        @statuses = Tip.statuses
        @topics = Topic.all
      end

      def edit
        @statuses = Tip.statuses
        @topics = Topic.all
      end

      def create
        @tip = Tip.new(tip_params)

        respond_to do |format|
          if @tip.save
            format.html { redirect_to(admin_tips_url, notice: "Tip was successfully created.") }
            format.json { render(:show, status: :created, location: @tip) }
          else
            format.html { render(partial: "shared/partials/errors", locals: { object: @tip }, status: :bad_request) }
          end
        end
      end

      def update
        respond_to do |format|
          if @tip.update(tip_params)
            format.html { redirect_to(admin_tips_url, notice: "Tip is successfully updated.") }
            format.json { render(:show, status: :ok, location: @tip) }
          else
            format.html { render(partial: "shared/partials/errors", locals: { object: @tip }, status: :bad_request) }
          end
        end
      end

      def destroy
        @tip.destroy
        redirect_to(admin_tips_url)
      end

      private

      def set_tip
        @tip = Tip.find(params[:id])
      end

      def tip_params
        params[:tip][:related_topics] = params[:tip][:related_topics].reject(&:empty?)

        params.require(:tip).permit(:topic_id, :name, :slug, :summary, :content, :author_id, :image,
          :meta_title, :meta_description, :h1_tag, :status, :status, :tag_list,
          related_topics: [])
      end
    end
  end
end
