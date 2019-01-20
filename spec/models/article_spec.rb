require 'rails_helper'

RSpec.describe Article do
  let(:user) { create(:user) }
  describe '#valid?' do
    context 'タイトルが空の場合' do
      let(:aritcle) { build(:article, user: user, title: nil, body: '記事本文') }
      it { expect(aritcle).to_not be_valid }
    end

    context '本文が空の場合' do
      let(:aritcle) { build(:article, user: user, title: '記事タイトル', body: nil) }
      it { expect(aritcle).to_not be_valid }
    end

    context 'タイトルと本文が入力されている場合' do
      let(:aritcle) { build(:article, user: user, title: '記事タイトル', body: '記事本文') }
      it { expect(aritcle).to be_valid }
    end
  end
end
