class Item < ApplicationRecord
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :sell_price, presence: true
  validates :image, presence: true
  validates :category_id, :sale_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, numericality: {
    other_than: 1, message: "can't be blank"}


  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sale_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :sell_price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
    presence: { message: '¥300~¥9,999,999(半角数字)で入力してください' }
  end
end
