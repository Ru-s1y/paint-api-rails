module Api
  module V1
    module Auth
      class UserTokenController < ApplicationController
        rescue_from UserAuth.not_found_exception_class, with: :not_found
        before_action :delete_cookie # Authenticatorモジュールから
        before_action :authenticate, only: [:create] # privateメソッドから

        # login
        def create
          cookies[token_access_key] = cookie_token # tokenをCookieに保存
          render json: {
            exp: auth.payload[:exp], # 有効期限
            user: entity.my_json # ユーザー
          }
        end

        # logout
        def destroy
          head(:ok) # before_actionでCookieが消されるのでヘッダーで成功を送るだけでいい
        end

        private
          # メールアドレスからアクティブなユーザーを探す
          def entity
            @_entity ||= User.find_by(email: auth_params[:email])
          end

          # ストロングパラメーター
          def auth_params
            params.require(:user).permit(:email, :password)
          end

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
              http_only: true, # JavaScriptからアクセスできないCookie
              # same_site: :none # Set-Cookieが弾かれるため(Rack2.1以上出ないと使えない)
            }
          end

          # entityが存在しない、entityのパスワードが一致しない場合に404エラーを返す
          # メールアドレスに一致するユーザーがいない、パスワードが一致しない場合にRecordNotFound
          def authenticate
            unless entity.present? && entity.authenticate(auth_params[:password])
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