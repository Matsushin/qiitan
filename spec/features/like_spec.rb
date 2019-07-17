require 'rails_helper'

feature 'Article Like' do
  background { login_as user, scope: :user }
  context 'いいね' do
    let(:user) { create(:user, email: 'yamada@qiitan.jp', username: 'yamada', confirmed_at: Time.current) }
    let(:user2) { create(:user, email: 'takeda@qiitan.jp', username: 'takeda', confirmed_at: Time.current) }
    let(:article) { create(:article, user: user2, title: '他人の記事') }
    let(:article2) { create(:article, user: user, title: '自分の記事') }

    scenario '他人が作成した記事にいいねできる', js: true do
      visit article_path(article)
      expect(page).to have_content '他人の記事'
      expect {
        find(".article__item-like-btn").click
      }.to change{ Like.count }.by(1)
      expect(page).to have_selector ".fa-check"

      visit root_path
      expect(page).to have_selector ".fa-thumbs-up"
    end

    scenario '自分が作成した記事にいいねできない', js: true do
      visit article_path(article2)
      expect(page).to have_content '自分の記事'
      expect {
        find(".article__item-like-btn").click
      }.to change{ Like.count }.by(0)
      expect(page).to have_selector ".fa-thumbs-up"

      visit root_path
      expect(page).not_to have_selector ".fa-thumbs-up"
    end
  end
end