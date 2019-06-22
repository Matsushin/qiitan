# frozen_string_literal: true
FactoryBot.define do
  factory :article do
    title { '記事タイトル' }
    body { '記事本文' }
    user
  end
end
