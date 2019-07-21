require 'rails_helper'

feature 'Sign up' do
  background do
    ActionMailer::Base.deliveries.clear
  end

  scenario '本人確認メールによるユーザ登録後、ログインする' do
    visit root_path
    expect(page).to have_content 'Qiitan にログイン'

    click_link 'ユーザー登録'
    expect(page).to have_content 'Qiitanへようこそ'

    fill_in 'ユーザ名', with: 'testuser_mail'
    fill_in 'メールアドレス', with: 'testuser@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'ユーザー登録'

    mail = ActionMailer::Base.deliveries.last
    body = mail.body.encoded
    url = body[/http[^"]+/]
    visit url
    expect(page).to have_content 'Qiitan にログイン'

    fill_in 'メールアドレス', with: 'testuser@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'Qiitan にログイン'
    expect(page).to have_content 'すべての投稿'
  end
end