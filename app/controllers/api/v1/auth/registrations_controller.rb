module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        rescue_from UserAuth.not_found_exception_class, with: :not_found
        before_action :delete_cookie # Authenticatorモジュールから

        def create
          @user = User.new(
            name: user_params[:name],
            email: user_params[:email],
            password: user_params[:password],
            password_confirmation: user_params[:password_confirmation]
          )

          if @user.save
            cookies[token_access_key] = cookie_token
            render json: {
              exp: auth.payload[:exp], # 有効期限
              user: entity.my_json # ユーザー
            }
          else
            errors_messages = @user.errors.keys.map { |key| [key, @user.errors.full_messages_for(key)]}.to_h
            render json: { message: errors_messages }
          end
        end

        private
          def user_params
            params.require(:user).permit(:name, :email, :password, :password_confimation)
          end

          # メールアドレスからアクティブなユーザーを探す
          def entity
            @_entity ||= User.find_by(email: user_params[:email])
          end

          # ストロングパラメーター
          # def auth_params
          #   params.require(:auth).permit(:email, :password)
          # end

          # トークンを発行する
          def auth
            @_auth ||= UserAuth::AuthToken.new(payload: { sub: entity.id })
          end

          # Cookieに保存するトークン
          def cookie_token
            {
              value: auth.token, # Cookieの値
              expires: Time.at(auth.payload[:exp]), # Cookieの有効期限
              secure: Rails.env.production?, # https通信でしかアクセスできないCookie(本番環境のみ)
              http_only: true # JavaScriptからkアクセスできないCookie
            }
          end

          # entityが存在しない、entityのパスワードが一致しない場合に404エラーを返す
          # メールアドレスに一致するユーザーがいない、パスワードが一致しない場合にRecordNotFound
          def authenticate
            unless entity.present? && entity.authenticate(user_params[:password])
              raise UserAuth.not_found_exception_class
            end
          end
          
          # NotFoundエラー発生時にヘッダーレスポンスのみを返す
          # status => Rack::Utils::SYMBOL_TO_STATUS_CODE
          def not_found
            head(:not_found)
          end
      end
    end
  end
end