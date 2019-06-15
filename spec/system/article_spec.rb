describe '投稿記事管理機能', type: :system do
  before do
    @user = User.create(
      username: "test",
      email: "test@example.com",
      password: "password",
      confirmed_at: Time.current
    )
    @user.password = "password"

    @user.save
  end
  it '投稿削除テスト' do
    visit new_user_session_path
    p @user.email
    p @user.authenticate? "password"
    p @user.authenticate?("password").to_s
    p "###################################"
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: "password"
    click_button "Qiitan にログイン"
    expect(current_path).to eq root_path

    visit new_article_path
    expect(current_path).to eq new_article_path
    fill_in "article_title", with: "Test"
    fill_in "article_body", with: "body"
    click_button "Qiitanに投稿"
    expect(page).to have_content 'Test'
    click_link "Test"
    click_button "削除する"
    page.accept_confirm '削除してもよろしいですか？'
    expect(page).to have_no_content "Test"
  end
end