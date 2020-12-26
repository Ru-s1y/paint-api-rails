module Api
  module V1
    class MypagesController < ApplicationController
      include Pagenation
      before_action :authenticate_user

      def index
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :desc).limit(6)
        @albums = Album.where(user_id: current_user.id).order(created_at: :desc).limit(6)
        render 'index.json.jbuilder'
      end

      def index_pictures
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(10)
        pagenation = resources_with_pagination(@pictures)
        render 'index_pictures.json.jbuilder'
      end

      # マイアルバムリスト
      def album_list
        @albums = Album.where(user_id: current_user.id)
        render json: @albums
      end

      # アルバム内のピクチャー取得
      def album_pictures
        @album = Album.find_by(id: params[:album_id])
        if @album
          render json: @album.pictures
        else
          render json: { message: "failed" }
        end
      end

      # アルバム登録
      def register_album
        @mylist = Mylist.create!(
          album_id: mylist_params[:album_id],
          picture_id: mylist_params[:picture_id]
        )
        if @mylist
          render json: { message: "success" }
        else
          render json: { message: "failed" }
        end
      end

      # アルバム登録解除
      def destroy_album
        @mylist = Mylist.find_by(
          album_id: params[:album_id], 
          picture_id: params[:picture_id]
        )
        if @mylist.destroy
          render json: { message: "success" }
        else
          render json: { message: "failed", mylist: @mylist.errors }
        end
      end

      def favorites
        @favorite_pictures = FavoritePicture.where(user_id: current_user.id).limit(6)
        @favorite_albums = FavoriteAlbum.where(user_id: current_user.id).limit(6)
        render 'favorites.json.jbuilder'
      end

      private
        def mylist_params
          params.require(:mylist).permit(:album_id, :picture_id)
        end
    end
  end
end