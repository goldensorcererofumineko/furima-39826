require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      before do
        item = FactoryBot.create(:item)
        user = FactoryBot.create(:user)
        @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
      end

      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_form).to be_valid
      end

      it 'user_idが空でなければ保存できる' do
        @order_form.user_id = 1
        expect(@order_form).to be_valid
      end

      it 'item_idが空でなければ保存できる' do
        @order_form.item_id = 1
        expect(@order_form).to be_valid
      end

      it '郵便番号が「3桁とハイフンに4桁」の組み合わせであれば保存できる' do
        @order_form.postcode = '123-4567'
        expect(@order_form).to be_valid
      end

      it '都道府県がid=1以外でなければ保存できる' do
        @order_form.prefecture_id = 2
        expect(@order_form).to be_valid
      end

      it '市区町村が空でなければ保存できる' do
        @order_form.city = '名古屋市'
        expect(@order_form).to be_valid
      end

      it '番地が空でなければ保存できる' do
        @order_form.address = '旭区１２３'
        expect(@order_form).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_form.building = ""
        expect(@order_form).to be_valid
      end

      it '電話番号が11桁以内かつハイフンなしであれば保存できる' do
        @order_form.phone_number = '12345678901'
        expect(@order_form).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      before do
        @order_form = OrderForm.new
      end

      it 'user_idが空だと保存できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空だと保存できないこと' do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode can't be blank", 'Postcode is invalid. Include hyphen(-)')
      end

      it '都道府県がid=1だと保存できないこと' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @order_form.city = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にハイフンがあると保存できないこと' do
        @order_form.phone_number = '123-1234-1234'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上あると保存できないこと' do
        @order_form.phone_number = '1234567890123'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が9桁以下では購入できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'トークンが空だと保存できないこと' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end

