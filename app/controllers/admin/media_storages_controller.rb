module Admin
  class MediaStoragesController < Admin::BaseController
    def create
      @media_storage = MediaStorage.create(image: params[:attachment])
      if @media_storage
        render(json: { message: "success",
                       url: @media_storage.image_url(public: true),
                       attachment_id: @media_storage.id },
         status: :created)
      else
        render(json: { message: @media_storage.errors.messages,
                       success: false },
         status: :bad_request)
      end
    end

    def destroy
      @media_storage = MediaStorage.find(params[:id])
      @media_storage.destroy

      respond_to do |format|
        format.json { render json: { status: :ok } }
      end
    end
  end
end
