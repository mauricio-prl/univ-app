FactoryBot.define do
  factory :student do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { 'password' }
  end
end
