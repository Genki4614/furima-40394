class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string      :item_name,              null: false
      t.text        :item_info,              null: false
      t.integer     :category_id ,           null: false   #activehash
      t.integer     :sale_status_id,         null: false   #activehash
      t.integer     :shipping_fee_status_id, null: false   #activehash
      t.integer     :prefecture_id,          null: false   #activehash 
      t.integer     :scheduled_delivery_id,  null: false   #activehash
      t.integer     :sell_price,             null: false
      t.references  :user,                   null: false , foreign_key: true
      t.timestamps
    end
  end
end
