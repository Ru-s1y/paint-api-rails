module Api
  module V1
    class HomesController < ApplicationController

      def index
        @pictures = Picture.where(publish: true).order(created_at: :desc).limit(6)
        @albums = Album.where(publish: true).order(created_at: :desc).limit(6)
        render json: {
          pictures: @pictures,
          albums: @albums
        }
      end
      
    end
  end
end