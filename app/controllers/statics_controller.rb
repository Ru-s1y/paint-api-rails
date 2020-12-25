class StaticsController < ApplicationController
  def home
    render json: { message: "Working!" }
  end
end