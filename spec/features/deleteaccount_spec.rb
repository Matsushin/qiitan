require 'rails_helper'

feature 'Delete Account' do
  background do
    @user = create(:user, email: 'yamada@qiitan.jp', username: 'yamada', confirmed_at: Time.current)
    login_as @user, scope: :user
    visit edit_user_registration_path(@user)
    click_button 'アカウントを削除する'
    expect(page).to have_content '退会する'
  end

  scenario '正しいパスワードを入力すると、アカウントを削除できる' do
    fill_in 'パスワード', with: 'password'
    click_button '退会する'

    expect(page).to have_content '退会完了'
    expect(@user.reload.deleted_at).not_to eq nil
  end

  scenario '誤ったパスワードを入力すると、現在と同じページにリダイレクトする' do
    fill_in 'パスワード', with: 'incorrect'
    click_button '退会する'

    expect(page).to have_content 'パスワードが間違っています。'
    expect(@user.reload.deleted_at).to eq nil
  end
end