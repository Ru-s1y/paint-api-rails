require 'rails_helper'

RSpec.describe 'Authenticator', type: :request do
  describe 'ユーザー登録' do
    it "正しくユーザーが登録される" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: 'password', password_confirmation: 'password' } }
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      # responseの確認
      # expect(json.exp).to is_valid
    end

    it "メールアドレスがないと弾かれる" do
      post '/api/v1/auth/registrations', params: { user: { email: '', name: 'testUser', password: 'password', password_confirmation: 'password' }}
      expect(response).to have_http_status(200)
      # エラーメッセージの確認
    end

    it "パスワードがないと失敗する" do
      post '/api/v1/auth/registrations', params: { user: { email: 'test@example.com', name: 'testUser', password: '', password_confirmation: 'password'}}
      expect(response).to have_http_status(200)
      # エラーメッセージの確認
    end

    it "確認用パスワードがないと失敗する" do
    end

    it "パスワードと確認用パスワードが一致しない" do
    end
  end

  describe 'ログイン関連' do
    it "非ログイン時のアクセス"
    it "ログイン時のアクセス"
  end
end