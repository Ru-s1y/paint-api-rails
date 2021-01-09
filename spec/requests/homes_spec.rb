require 'rails_helper'

RSpec.describe 'Authenticator', type: :request do
  describe "GET /homes/index" do
    it "新着ピクチャーが表示される" do
      get api_v1_homes_path
      expect(response).to have_http_status(200)
    end
  end
end