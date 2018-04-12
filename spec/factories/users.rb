FactoryBot.define do

  factory :user do
    sequence(:name) { 'user' }
    email { 'user@example.com' }
    password 'password'
    password_confirmation 'password'
  end

end
