require 'rails_helper'

feature 'Article Stock' do
  background { login_as user, scope: :user }
  context 'ストック' do
    let(:user) { create(:user, email: 'yamada@qiitan.jp', username: 'yamada', confirmed_at: Time.current) }
    let(:user2) { create(:user, email: 'takeda@qiitan.jp', username: 'takeda', confirmed_at: Time.current) }
    let(:article) { create(:article, user: user2, title: 'テスト記事タイトル') }
    scenario '記事をストックしてストック一覧画面にアクセスする', js: true do
      visit article_path(article)
      expect(page).to have_content 'テスト記事タイトル'
      find(".article__item-stock-btn").click
      expect(page).to have_selector ".article__item-stock-check"

      visit stocks_path
      expect(page).to have_content "ストック一覧"
      expect(page).to have_content "テスト記事タイトル"
    end
  end
end
