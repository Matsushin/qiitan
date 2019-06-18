describe '投稿記事管理機能', type: :system do
  let(:user) { create(:user, email: 'test@example.com', username: 'test_user', confirmed_at: Time.current) }
  before do
    user.password = "password"
    user.save
    visit new_user_session_path
    fill_in 'メールアドレス', with: "test@example.com"
    fill_in 'パスワード', with: "password"
    click_button "Qiitan にログイン"
    expect(current_path).to eq root_path
    visit new_article_path
    expect(current_path).to eq new_article_path
    fill_in "article_title", with: "Test"
    fill_in "article_body", with: "body"
    click_button "Qiitanに投稿"
  end

  it '投稿削除テスト' do
    expect(current_path).to eq article_path(Article.last)
    expect(page).to have_content 'Test'
    click_link "削除する"
    expect(current_path).to eq root_path
    expect(page).to have_no_content "Test"
    expect(Article.count).to be_zero
  end

  scenario "ストック検索テスト" do
    expect(current_path).to eq article_path(Article.last)
    find(".article__item-stock-btn").click
    visit stocks_path
    within '.stock_search' do
      find(".form-control").set("Test")
      find(".form-control").click
    end
    expect(current_path).to eq stocks_path
    expect(page).to have_content "Test"
  end
end