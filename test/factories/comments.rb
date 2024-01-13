FactoryBot.define do
  factory :comment do
    text { 'text' }
    user
    post
  end
end
