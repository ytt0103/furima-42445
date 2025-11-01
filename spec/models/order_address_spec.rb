require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    # ユーザーと商品のファクトリーを作成しておき、それを元にOrderAddressのインスタンスを作成
    let(:user) { FactoryBot.create(:user) }
    let(:item) { FactoryBot.create(:item) }
    # OrderAddress用のファクトリーがある前提でbuild
    let(:order_address) { FactoryBot.build(:order_address, user_id: user.id, item_id: item.id) }
    
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        # FactoryBotでtokenが設定されているため、これでto be_validが通る
        expect(order_address).to be_valid
      end
      
      it '建物名が空でも保存できること' do
        order_address.building = ''
        expect(order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では保存できないこと' do
        order_address.token = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では保存できないこと' do
        order_address.user_id = nil
        order_address.valid?
        # User Id can't be blank に変更
        expect(order_address.errors.full_messages).to include("User Id can't be blank")
      end

      it 'item_idが空では保存できないこと' do
        order_address.item_id = nil
        order_address.valid?
        # Item Id can't be blank に変更
        expect(order_address.errors.full_messages).to include("Item Id can't be blank")
      end
      
      it '郵便番号が空では保存できないこと' do
        order_address.postal_code = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      
      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと保存できないこと' do
        order_address.postal_code = '1234567'
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      
      it '都道府県が「---」では保存できないこと' do
        order_address.prefecture_id = 1
        order_address.valid?
        # バリデーションがnumericality: { other_than: 1 }の場合、このメッセージになるため変更
        expect(order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      
      it '市区町村が空では保存できないこと' do
        order_address.city = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("City can't be blank")
      end
      
      it '番地が空では保存できないこと' do
        order_address.block = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Block can't be blank")
      end
      
      it '電話番号が空では保存できないこと' do
        order_address.phone_number = ''
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      
      it '電話番号にハイフンが含まれていると保存できないこと' do
        order_address.phone_number = '090-1234-5678'
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number is invalid. Enter a 10 or 11 digit half-width number without hyphens")
      end
      
      it '電話番号が9桁以下では保存できないこと' do
        order_address.phone_number = '090123456'
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number is invalid. Enter a 10 or 11 digit half-width number without hyphens")
      end
      
      it '電話番号が12桁以上では保存できないこと' do
        order_address.phone_number = '090123456789'
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number is invalid. Enter a 10 or 11 digit half-width number without hyphens")
      end

      it '電話番号が半角数字以外では保存できないこと' do
        order_address.phone_number = '０９０１２３４５６７８'
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number is invalid. Enter a 10 or 11 digit half-width number without hyphens")
      end
    end
  end
end