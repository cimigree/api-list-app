FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    brand_name { Faker::Company.name }
    purchased false
    frequency "Weekly"
    category_id nil
  end
end