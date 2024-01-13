FactoryBot.define do
  factory :user do
    name { 'user' }
    sequence(:email) { |i| "test#{i}@#{i}" }
  end
end
