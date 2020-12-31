Rails.application.routes.draw do
  root to: "statics#home"
  namespace :api do
    namespace :v1 do
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
      
      # picture
      resources :pictures, only:[:create] do
        get :index, on: :collection
        patch :update, on: :collection
        delete :destroy, on: :collection
      end

      # album
      resources :albums, only:[:create] do
        get :index, on: :collection
        get :pictures, on: :collection
        patch :update, on: :collection
        delete :destroy, on: :collection
        get :thumbnail, on: :collection
      end

      # favorite
      resources :favorite_pictures, only: [:create] do
        get :show, on: :collection
        delete :destroy, on: :collection
      end

      resources :favorite_albums, only: [:create] do
        get :show, on: :collection
        delete :destroy, on: :collection
      end

      # mypage
      resources :mypages, only: [] do
        get :index, on: :collection
        get :index_pictures, on: :collection
        get :album_list, on: :collection
        get :favorites, on: :collection
        get :album_pictures, on: :collection
        post :register_album, on: :collection
        delete :destroy_album, on: :collection
      end

      # home
      resources :homes, only: [] do
        get :index, on: :collection
      end
    end
  end
end
