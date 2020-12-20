module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        def create
          @user = User.new(
            name: user_params[:name],
            email: user_params[:email].downcase,
            password: user_params[:password],
            password_confirmation: user_params[:password_confirmation]
          )
          if @user.save
            render json: @user
          else
            render json: @user.error
          end
        end

        def destroy
          @user = User.find(params[:id])
          @user.destroy
          render json: @user
        end

        private
          def user_params
            params.require(:user).permit(:name, :password, :password_confimation, :guest)
          end
      end
    end
  end
end