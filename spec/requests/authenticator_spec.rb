require 'rails_helper'

RSpec.describe 'Authenticator', type: :request do
  describe 'ユーザー登録' do
    it "正しくユーザーが登録される" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: 'password', password_confirmation: 'password' } }
      # responseの確認
      expect(response).to have_http_status(200)
      # 中身の確認
      json = JSON.parse(response.body)
    end

    it "メールアドレスがないと無効になる" do
      post '/api/v1/auth/registrations', params: { user: { email: '', name: 'testUser', password: 'password', password_confirmation: 'password' }}
      expect(response).to have_http_status(401)
      # エラーメッセージの確認
    end

    it "パスワードがないと無効になる" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: '', password_confirmation: 'password'}}
      expect(response).to have_http_status(401)
      # エラーメッセージの確認
    end

    it "確認用パスワードがないと無効になる" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: 'password', password_confirmation: ''}}
      expect(response).to have_http_status(200)
      # 登録される
    end

    it "パスワードと確認用パスワードが一致しないと無効になる" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: 'password', password_confirmation: 'pass'}}
      expect(response).to have_http_status(200)

    end
  end

  describe 'ログイン関連' do
    before do
      User.create(name: "user", email: "test@example.com", password: "password", password_confirmation: "password")
    end

    it "正しいメールアドレスとパスワードを入力していると成功" do
      post '/api/v1/auth/user_token', params: { user: { email: "test@example.com", password: "password" }}
      expect(response).to have_http_status(200)
    end

    it "メールアドレスを入力していないと無効(404)" do
      post '/api/v1/auth/user_token', params: { user: { email: "", password: "password" }}
      expect(response).to have_http_status(404)
    end
    it "パスワードを入力していないと無効(404)" do
      post '/api/v1/auth/user_token', params: { user: { email: "test@example.com", password: "" }}
      expect(response).to have_http_status(404)
    end
  end
end