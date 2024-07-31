class RecordDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :prefecture_id, :postal_code, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city, :address, :token, :user_id, :item_id
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id:, item_id:)
    PayForm.create(postal_code:, prefecture_id:, city:, address:, building:, phone_number:, order_id: order.id)
  end
end
