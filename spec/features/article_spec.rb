feature '投稿記事管理機能' do
  let(:user) { create(:user, email: 'test@example.com', username: 'test_user', confirmed_at: Time.current) }
  let(:user2) { create(:user, email: 'test2@example.com', username: 'test_user2', confirmed_at: Time.current) }
  let!(:article) { create(:article, user: user2, title: '記事タイトル2', body: '記事本文2') }
  background do
    user.password = 'password'
    user.save
    visit new_user_session_path
    fill_in 'メールアドレス', with: "test@example.com"
    fill_in 'パスワード', with: "password"
    click_button "Qiitan にログイン"
    expect(current_path).to eq root_path
    visit new_article_path
    expect(current_path).to eq new_article_path
    fill_in "article_title", with: "記事タイトル1"
    fill_in "article_body", with: "記事本文1"
    click_button "Qiitanに投稿"
  end

  scenario '投稿を削除する' do
    expect(current_path).to eq article_path(Article.last)
    expect(page).to have_content '記事タイトル1'
    click_link "削除する"
    expect(current_path).to eq root_path
    expect(page).to have_no_content "記事タイトル1"
    expect(user.articles.count).to be_zero
  end

  scenario '記事を検索する', js: true do
    fill_in "q[title_or_body_cont]", with: "記事タイトル2" + "\n"

    expect(page).to have_content "検索結果"
    expect(current_path).to eq search_index_path
    expect(page).to have_content "記事タイトル2"
    expect(page).to_not have_content "記事タイトル1"
  end

  scenario 'ストックした記事を検索する', js: true do
    expect(current_path).to eq article_path(Article.last)
    find(".article__item-stock-btn").click
    expect(page).to have_selector ".article__item-stock-check"
    visit stocks_path
    within '.article__item-stock-search' do
      fill_in "q[title_or_body_cont]", with: "記事タイトル1" + "\n"
    end
    expect(current_path).to eq search_index_path
    expect(page).to have_content "検索結果"
    expect(page).to have_content "記事タイトル1"
    expect(page).to_not have_content "記事タイトル2"
  end
end
