module Api
  module V1
    class MypagesController < ApplicationController
      before_action :authenticate_user

      def index
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :desc).limit(6)
        @albums = Album.where(user_id: current_user.id).order(created_at: :desc).limit(6)
        render 'index.json.jbuilder'
      end

      def index_picture
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(10)
        pagenation = resources_with_pagination(@pictures)
        render 'index_pictures.json.jbuilder'
      end

      def index_albums
        @albums = Album.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(10)
        pagenation = resources_with_pagenation(@albums)
        render 'index_albums.json.jbuilder'
      end

      def album_list
        @albums = Album.where(user_id: current_user.id)
        render json: @albums
      end

      def favorites
        @favorite_pictures = FavoritePicture.where(user_id: current_user.id).limit(6)
        @favorite_albums = FavoriteAlbum.where(user_id: current_user.id).limit(6)
        render 'favorites.json.jbuilder'
      end
    end
  end
end