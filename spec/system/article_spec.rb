require 'rails_helper'

describe '投稿記事管理機能', type: :system do
  before do
    @user = User.create(
      username: "test",
      email: "test@example.com",
      password: "password"
    )
  end
  it '投稿削除テスト' do
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button "Qiitan にログイン"
    expect {
      visit new_article_path
      fill_in "article_title", with: "Test"
      fill_in "article_body", with: "body"
      click_button "Qiitanに投稿"
      expect(page).to have_content 'Test'
      click_link "Test"
      click_button "削除する"
      page.accept_confirm '削除してもよろしいですか？？'
      expect(page).to have_no_content "Test"}
  end
end
