require 'rails_helper'

feature 'Home' do
  background { login_as user, scope: :user }
  let!(:article1) { create(:article, user: user, title: '記事タイトル1 home_spec確認', body: '記事本文1') }
  let!(:article2) { create(:article, user: user, title: '記事タイトル2', body: '記事本文2') }

  context 'Home User Container' do
    let(:user) { create(:user, email: 'test@example.com', username: 'test_user', confirmed_at: Time.current) }

    scenario 'HOME画面の自分の「記事」の表示の確認', js: true do
      visit root_path
      expect(page).to have_selector '.articles-count', text: '2'
    end

    scenario 'HOME画面の自分の「Contributtion(貢献数)」の表示の確認', js: true do
      visit root_path
      expect(page).to have_selector '.contributtion-count', text: '0'
    end

    scenario 'HOME画面の自分の「ユーザー名」からユーザー詳細画面に遷移できる', js: true do
      visit root_path
      expect(page).to have_content '記事'
      find(".home__user-name").click
      expect(current_path).to eq user_path(user)
    end

    scenario 'HOME画面の自分の「投稿記事数」からユーザー詳細画面に遷移できる', js: true do
      visit root_path
      expect(page).to have_content '記事'
      find(".articles-count").click
      expect(current_path).to eq user_path(user)
    end
  end
end