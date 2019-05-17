FactoryBot.define do
  factory :user do
    email { }
    password { }
    trait :guest_user do
      email { "#{Time.now}test@guest.com" }
    end
  end
end
