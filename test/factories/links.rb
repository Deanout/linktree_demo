# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    name { 'MyString' }
    url { 'MyString' }
    active { false }
    position { 1 }
  end
end
