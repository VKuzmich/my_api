

FactoryBot.define do
  factory :transformer do |f|
    f.user_url { FFaker::Internet.domain_name }
    f.nickname { "QWERT"}

  end
end