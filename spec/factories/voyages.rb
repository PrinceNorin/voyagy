FactoryBot.define do
  factory :voyage do
    from_loc { Faker::Address.full_address }
    to_loc { Faker::Address.full_address }
    departured_at { DateTime.current }
    arrived_at { 2.hours.from_now }
    vessel
  end
end
