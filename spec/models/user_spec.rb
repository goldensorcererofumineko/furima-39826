require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての入力事項が、存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上半角英数字であれば登録できる' do
        @user.password = '123qwe'
        @user.password_confirmation = '123qwe'
        expect(@user).to be_valid
      end

      it '名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.last_name = '鈴木'
        expect(@user).to be_valid
      end
      it '名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = 'タナカ'
        expect(@user).to be_valid
      end
      it '名字のフリガナが全角（カタカナ）であれば登録できる' do
        @user.last_name_kana = 'スズキ'
        expect(@user).to be_valid
      end
      it '名前のフリガナが全角（カタカナ）であれば登録できる' do
        @user.first_name_kana = 'タナカ'
        expect(@user).to be_valid
      end
      it 'emailに@が含まれている場合、有効であること' do
        @user.email = 'valid@example.com'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do

      it 'ニックネームが空欄だと保存できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    
      it 'メールアドレスに@を含まない場合は登録できない' do
        @user = User.new(email: 'invalid-email.com')  
        @user.valid?  
        expect(@user.errors[:email]).to include('is invalid')
      end

      it 'メールアドレスがすでに登録しているユーザーと重複していると保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが空欄だと保存できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank" )
      end
      it 'パスワード（確認含む）が5文字以下だと保存できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワード（確認含む）が半角英数字でないと保存できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid.Include both letters and numbers')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'password'
        expect(@user).not_to be_valid
        expect(@user.errors[:password]).to include('is invalid.Include both letters and numbers')
      end
    
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        expect(@user).not_to be_valid
        expect(@user.errors[:password]).to include('is invalid.Include both letters and numbers')
      end
    
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード123'
        expect(@user).not_to be_valid
        expect(@user.errors[:password]).to include('is invalid.Include both letters and numbers')
      end

      it 'パスワード（確認）が空欄だと保存できない' do
        @user.password = '123qwe'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '全角（漢字・ひらがな・カタカナ）名字が空欄だと保存できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '全角（漢字・ひらがな・カタカナ）名前が空欄だと保存できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名字が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end
      it '名前が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end

      it '全角（漢字・ひらがな・カタカナ）名字が空欄だと保存できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '全角（漢字・ひらがな・カタカナ）名前が空欄だと保存できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名字のフリガナが全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end
      it '名前のフリガナが全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end
      it '生年月日が空欄だと保存できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")

      end
    end
  end
end