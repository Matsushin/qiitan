require 'rails_helper'

describe '投稿記事管理機能', type: :system do
  describe '投稿記事削除機能' do
    before do
      user_a = FactoryBot.create(:user)
      FactoryBot.create(:article, title: '最初の記事', user: user_a)
    end

    context 'ユーザーがログインしている時' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス'
        fill_in 'パスワード'
      end
    end

    it 'ユーザーAが作成した記事が表示される' do
      expect(page).to have_content '最初の記事'
    end
  end
end