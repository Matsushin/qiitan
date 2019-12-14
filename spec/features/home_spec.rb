require 'rails_helper'

feature 'Home' do
  background { login_as user, scope: :user }
  context 'Home User Window' do
    let(:user) { create(:user, email: 'yamada@qiitan.jp', username: 'yamada', confirmed_at: Time.current) }

    scenario 'HOME画面から自分の「ユーザー名」からユーザー詳細画面に遷移できる', js: true do
      visit root_path
      expect(page).to have_content 'Items'

      find(".h4").click
      expect(page).to have_content "最近の投稿"

    end

    scenario 'HOME画面から自分の「投稿記事数」からユーザー詳細画面に遷移できる', js: true do
      visit root_path
      expect(page).to have_content 'Items'

      find(".a").click
      expect(page).to have_content "最近の投稿"

    end
  end
end