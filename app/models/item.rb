class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_sales_status
  belongs_to :item_shipping_fee_status
  belongs_to :item_scheduled_delivery
  belongs_to :prefecture
  has_one_attached :image
  belongs_to :user

  validates :item_info, presence: true
  validates :item_price, presence: true
  validates :item_name, presence: true
  validates :image, presence: true
  validates :item_price, presence: true,
  numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }


  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :item_sales_status_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :item_shipping_fee_status_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :item_scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
end
