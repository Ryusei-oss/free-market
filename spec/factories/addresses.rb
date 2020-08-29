FactoryBot.define do
  factory :address do
    association :user
    postal_code {"12345"}
    area        {"大阪府"}
    city        {"大阪市"}
    house_number{"1234"}
  end
end
