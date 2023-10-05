require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '新規商品出品' do
    context '新規出品がうまくいくとき' do
      it '全ての入力事項が、存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規出品がうまくいかないとき' do
      it 'imageが空欄だと保存できない' do
        @item.image = nil 
        @item.valid? 
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_infoが空欄だと保存できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      
      it 'item_priceが空欄だと保存できない' do
        @item.item_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank")
      end

      it 'item_priceが¥300未満の場合は保存できない' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price must be greater than or equal to 300")
      end
      
      it 'item_priceが¥10,000,000以上の場合は保存できない' do
        @item.item_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price must be less than or equal to 9999999")
      end
      
      it 'item_priceが半角数字でない場合は保存できない' do
        @item.item_price = "あいうえお" 
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not a number")
      end

      it 'item_nameが空欄だと保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      
      it 'item_category_idが1の場合、保存できない' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      
      it 'item_sales_status_idが1の場合、保存できない' do
        @item.item_sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item sales status can't be blank")
      end
      
      it 'item_shipping_fee_status_idが1の場合、保存できない' do
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item shipping fee status can't be blank")
      end
      
      it 'item_scheduled_delivery_idが1の場合、保存できない' do
        @item.item_scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item scheduled delivery can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end