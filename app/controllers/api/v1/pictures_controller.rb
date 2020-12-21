module Api
  module V1
    class PicturesController < ApplicationController
      include Pagenation
      before_action :authenticate_user, only: [:create, :update, :destroy]

      def index
        @pictures = Picture.where(publish: true).order(created_at: :desc).page(params[:page]).per(10)
        pagenation = resources_with_pagination(@pictures)
        render 'index.json.jbuilder'
      end

      def create
        image = picture_params[:image]
        uri = URI.parse(image)
        if uri.schema == "data" then
          data = decode(uri)
          extension = extension(uri)
        end
      end

      def update
        if @picture.update(picture_params)
          render json: @picture
        else
          render json: @picture.errors
        end
      end

      def destroy
        @picture.destroy
        render json: @picture
      end

      private
        def picture_params
          params.require(:picture).permit(:name, :description, :image, :publish)
        end

        def set_picture
          @picture = Picture.find_by(id: params[:id])
        end
    end
  end
end