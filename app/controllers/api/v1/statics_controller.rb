module Api
  module V1
    class StaticsController < ApplicationController
      def home
        render json: { message: "Working!" }
      end
    end
  end
end