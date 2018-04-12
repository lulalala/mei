# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content 'foo'
    pos 1
    email 'foo@example.com'
  end
end
