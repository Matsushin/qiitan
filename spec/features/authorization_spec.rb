require 'rails_helper'

feature 'Authorization' do
  background do
    user.password = 'password'
    user.save
  end
  context 'ログイン' do
    let(:user) { create(:user, email: 'admin@qiitan.jp', username: 'qiitan_user', confirmed_at: Time.current) }
    scenario 'ログインできる' do
      visit root_path
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Qiitan にログイン'
      fill_in 'メールアドレス', with: 'admin@qiitan.jp'
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'すべての投稿'
    end
  end
end
