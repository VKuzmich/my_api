
FactoryBot.define do
  factory :transformer do |f|
    f.user_url { FFaker::Internet.domain_name }
  end
end