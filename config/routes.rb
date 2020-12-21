Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root to: "statics#home"
      namespace :auth do
        # users
        resources :users, only:[] do
          get :current_user, action: :show, on: :collection
        end

        # sign_up
        resources :registrations, only: [:create]

        # login, logout
        resources :user_token, only: [:create] do
          delete :destroy, on: :collection
        end
      end
    end
  end
end
