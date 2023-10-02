FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.unique.email}
    password              {'1a'+Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name { '鈴木' }
    first_name { '田中' }
    last_name_kana { 'スズキ' }
    first_name_kana { 'タナカ' }
    birth_date { Faker::Date.between(from: 65.years.ago, to: 18.years.ago) }
  end
end