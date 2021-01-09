require 'rails_helper'

RSpec.describe 'UserToken', type: :request do
  describe "POST /user_token/create" do
    it "ログイン失敗(属性がない)" do
      post '/api/v1/auth/user_token', params: { user: { email: "", password: "" } }
      expect(response).to have_http_status(404)
    end

    it "ログイン失敗(Emailがない)" do
      post '/api/v1/auth/user_token', params: { user: { email: "", password: "password" } }
      expect(response).to have_http_status(404)
    end
    
    it "ログイン失敗(Passwordがない)" do
      post '/api/v1/auth/user_token', params: { user: { email: "test@example.com", password: "" } }
      expect(response).to have_http_status(404)
    end
  end
end