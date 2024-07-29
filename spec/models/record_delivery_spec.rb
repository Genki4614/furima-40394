require 'rails_helper'

RSpec.describe RecordDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @record_delivery = FactoryBot.build(:record_delivery, user_id: user.id, item_id: item.id)
  end
  describe '新規購入' do
    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@record_delivery).to be_valid
      end
      it '建物名は空でも保存できること' do
        @record_delivery.building = ''
        expect(@record_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では保存できない' do
        @record_delivery.postal_code = ''
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が3桁ハイフン4桁以外では保存できない' do
        @record_delivery.postal_code = '8180133'
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が空では保存できない' do
        @record_delivery.prefecture_id = nil
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では保存できない' do
        @record_delivery.city = ''
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '電話番号が空では保存できない' do
        @record_delivery.phone_number = ''
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10桁以上11桁以下以外では保存できない' do
        @record_delivery.phone_number = '080123412'
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が半角数字以外では保存できない' do
        @record_delivery.phone_number = '０８０５８０３３０９７'
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @record_delivery.token = nil
        @record_delivery.valid?
        expect(@record_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
