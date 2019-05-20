FactoryBot.define do
  factory :upload do
    link { "MyString" }
    reference { "MyString" }
    archived { false }
    user { nil }
  end
end
