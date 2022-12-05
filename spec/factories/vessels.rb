FactoryBot.define do
  factory :vessel do
    name { Faker::Name.name }
    owner_id { Faker::Barcode.isbn }
    naccs { Faker::Barcode.isbn }
    user
  end
end
