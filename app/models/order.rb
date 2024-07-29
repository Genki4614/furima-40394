class Order < ApplicationRecord
  has_one :pay_form
  belongs_to :item
  belongs_to :user
end
