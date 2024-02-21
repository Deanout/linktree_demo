FactoryBot.define do
  factory :social do
    name { "MyString" }
    url { "MyString" }
    active { false }
    position { 1 }
    user { nil }
  end
end
