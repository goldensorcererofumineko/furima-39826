FactoryBot.define do
  factory :order_form do
    postcode { '123-1234'}
    prefecture_id { 3 }
    city { '横浜市緑区' }
    address { '3-4' }
    building { '青山ビル' }
    phone_number { '09012341234' }
    token {"tok_abcdefghijk00000000000000000"}

    user_id { create(:user).id } 
    item_id { create(:item).id } 
  end
    
end