FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "test#{n}@gmail.com"}
    password "test12345"
    password_confirmation "test12345"
  end
end
