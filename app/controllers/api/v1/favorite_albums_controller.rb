module Api
  module V1
    class FavoriteAlbumsController < ApplicationController
      before_action :set_album
      before_action :authenticate_user

      def show
        @favorite = FavoriteAlbum.find_by(album_id: params[:id])
        if @favorite
          render json: @favorite
        else
          render json: { message: "null" }
        end
      end

      def create
        if @album.user_id != current_user.id
          @favorite = FavoriteAlbum.create(
            user_id: current_user.id, 
            album_id: @album.id
          )
        end
        render json: @favorite
      end

      def destroy
        @favorite = FavoriteAlbum.find_by(
          user_id: current_user.id,
          album_id: @album.id
        )
        @favorite.destroy
        render json: @favorite
      end

      private
        def set_album
          @album = Album.find(params[:id])
        end
    end
  end
end