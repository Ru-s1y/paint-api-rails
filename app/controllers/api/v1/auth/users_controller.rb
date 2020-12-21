module Api
  module V1
    module Auth
      class UsersController < ApplicationController
        before_action :authenticate_user

        # 現在のユーザーを探す
        def show
          render json: current_user.my_json
        end
      end
    end
  end
end