require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規出品' do
    context '新規出品できる時' do
      it '各登録フォームへ記入ができている場合商品を登録できる' do
        expect(@item).to be_valid
      end
   end
   
   context '新規出品できない時' do
    it '商品画像が空' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品名が空' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end
    it '商品の説明が空' do
      @item.item_info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item info can't be blank")
    end
    it '商品価格が空' do
      @item.sell_price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Sell price can't be blank")
    end
    it '商品カテゴリが「---」' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態が「---」' do
      @item.sale_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Sale status can't be blank")
    end
    it '配送料の負担が「---」' do
      @item.shipping_fee_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
    end
    it '発送元の地域が「---」' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '発送までの日数が「---」' do
      @item.scheduled_delivery_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
    end
    it '販売価格が300円未満' do
      @item.sell_price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Sell price is out of setting range")
    end
    it '販売価格が9,999,999円より大きい' do
      @item.sell_price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Sell price is out of setting range")
    end
    it '販売価格が全角文字' do
      @item.sell_price = '１００００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Sell price Half-width number")
    end
    it 'userが紐づいていない場合は登録できない' do
    @item.user = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("User must exist")
    end
   end
  end
end
