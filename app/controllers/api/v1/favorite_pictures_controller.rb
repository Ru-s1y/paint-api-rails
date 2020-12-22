module Api
  module V1
    class FavoritePicturesController < ApplicationController
      before_action :authenticate_user
      before_action :set_picture

      def show
        @favorite = FavoritePicture.find_by(picture_id: params[:id])
        if @favorite
          render json: @favorite
        else
          render json: { message: "null" }
        end
      end

      def create
        if @picture.user_id != current_user.id
          @favorite = FavoritePicture.create(
            user_id: current_user.id, 
            picture_id: @picture.id
          )
        end
        render json: @favorite
      end

      def destroy
        @favorite = FavoritePicture.find_by(
          user_id: current_user.id,
          picture_id: @picture.id
        )
        @favorite.destroy
        render json: @favorite
      end

      private
        def set_picture
          @picture = Picture.find(params[:id])
        end
    end
  end
end