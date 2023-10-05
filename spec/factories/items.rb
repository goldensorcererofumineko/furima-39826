FactoryBot.define do
  factory :item do

    item_name  { Faker::Commerce.product_name }                  
    item_price  { Faker::Number.between(from: 300, to: 9_999_999) }                
    item_info  { Faker::Lorem.paragraph }                 
    item_category_id  { Faker::Number.between(from: 2, to: 12) }          
    item_sales_status_id  { Faker::Number.between(from: 2, to: 5) }     
    item_shipping_fee_status_id  { Faker::Number.between(from: 2, to: 3) }
    item_scheduled_delivery_id  { Faker::Number.between(from: 2, to: 3) }
    prefecture_id  { Faker::Number.between(from: 2, to: 48) }             
    
    association :user, factory: :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
