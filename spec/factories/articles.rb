# frozen_string_literal: true
FactoryBot.define do
  factory :article do
    user
    title { '記事タイトル' }
    body { '記事本文' }
  end
end
