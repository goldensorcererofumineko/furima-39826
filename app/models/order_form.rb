class OrderForm < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :address
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :city
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
  end



  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number)
  end
end
