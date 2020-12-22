module Api
  module V1
    class AlbumsController < ApplicationController

      include Pagenation
      before_action :authenticate_user, except: [:index, :thumbnail]
      before_action :set_album, only: [:update, :destroy, :thumbnail]

      def index
        @albums = Album.where(publish: true).order(created_at: :desc).page(params[:page]).per(10)
        pagenation = resources_with_pagination(@albums)
        render 'index.json.jbuilder'
      end

      def create
        @album = Album.new(
          name: album_params[:name],
          description: album_params[:description],
          publish: "false",
          user_id: current_user.id
        )
        if @album.save
          render json: @album
        else
          render json: @album.errors
        end
      end

      def update
        if @album.update(album_params)
          render json: @album
        else
          render json: @album.errors
        end
      end

      def destroy
        if @album.destroy
          render json: @album
        else
          render json: @album.errors
        end
      end

      def thumbnail
        @picture = Picture.find_by(album_id: @album.id, publish: true)
        render json: @picture
      end

      private
        def album_params
          params.require(:album).permit(:name, :description, :publish)
        end

        def set_album
          @album = Album.find(params[:id])
        end
    end
  end
end