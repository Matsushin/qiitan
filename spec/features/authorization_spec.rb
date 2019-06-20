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

  context 'JS動作確認用' do
    let(:user) { create(:user, email: 'admin@qiitan.jp', username: 'qiitan_user', confirmed_at: Time.current) }
    let(:article) { create(:article, user: user, title: 'テスト記事タイトル') }
    scenario "ストック検索テスト", js: true do
      visit root_path
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Qiitan にログイン'
      fill_in 'メールアドレス', with: 'admin@qiitan.jp'
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン'
      expect(current_path).to eq root_path

      visit article_path(article)
      expect(current_path).to eq article_path(article)
      find(".article__item-stock-btn").click
      visit stocks_path
      expect(page).to have_content "ストック一覧"
      expect(page).to have_content "タイトル"
      within '.stock_search' do
        find(".form-control").set("タイトル")
        find(".form-control").click
      end
      expect(current_path).to eq stocks_path
      expect(page).to have_content "タイトル"
    end
  end
end
