# frozen_string_literal: true

FactoryBot.define do
  factory :theme do
    name { 'MyString' }
    theme_type { 'MyString' }
    premium { false }
    css_value { 'MyString' }
  end
end
