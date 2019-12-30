FactoryBot.define do
  factory :course do
    short_name { FFaker::Currency.code }
    name { FFaker::Currency.name }
    description { FFaker::DizzleIpsum.paragraph }
  end
end
