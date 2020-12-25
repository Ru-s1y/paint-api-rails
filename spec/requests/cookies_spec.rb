require 'rails_helper'

RSpec.describe 'Cookies', type: :request do
  describe 'Cookie の SameSite 属性' do
    before do
      user = create :user
      login_as user
    end
    it 'User-Agent指定無しの場合 SameSite=None がつく' do
      get new_user_session_path
      expect(response.headers['Set-Cookie']).to match /_your_app_session=.*SameSite=None/
    end

    it 'SameSite=Lax がデフォルトになる Chrome 80 では SameSite=None がつく' do
      mac_chrome_80 = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.42 Safari/537.36      '
      win_chrome_80 = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.16 Safari/537.36'

      get new_user_session_path, headers: { 'User-Agent' => mac_chrome_80 }
      expect(response.headers['Set-Cookie']).to match /_your_app_session=.*SameSite=None/

      get new_user_session_path, headers: { 'User-Agent' => win_chrome_80 }
      expect(response.headers['Set-Cookie']).to match /_your_app_session=.*SameSite=None/
    end

    it 'SameSite=Noneの扱いにバグがある iOS12 Safari では SameSite=None がつかない' do
      iphone_ios12_user_agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1'
      get new_user_session_path, headers: { 'User-Agent' => iphone_ios12_user_agent }
      expect(response.headers['Set-Cookie']).to include '_your_app_session='
      expect(response.headers['Set-Cookie']).not_to include 'SameSite'
    end
  end
end