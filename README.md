## users テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| birthday           | date   | null: false |

### Association
- has_many :items
- has_many :purchase_records

## itemsレコード
|Column                 |Type    | Options     |
|-----------------------|--------|-------------|
| item_name             | string | null: false |
| item_info             | text   | null: false |
| category_id           | integer| null: false |
| sale_status_id        | integer| null: false |
| shipping_fee_status_id| integer| null: false |
| prefecture_id         | integer| null: false |
| scheduled_deliver_id  | integer| null: false |
| sell_price            | integer| null: false |
| user                  | references | null: false | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase_record

## pay_forms レコード
|Column               |Type    | Options     |
|---------------------|--------|-------------|
| postal_code         | string | null: false |
| prefecture_id       | integer| null: false |
| city                | string | null: false |
| address             | string | null: false |
| building            | string |
| phone_number        | string | null: false |
| purchase_record     | references | null: false |foreign_key: true |


### Association
- belongs_to: purchase_record

## purchase_records
|Column               |Type    | Options     |
|---------------------|--------|-------------|
| user                | references| foreign_key: true |
| item                | references| foreign_key: true |

### Association
- belongs_to: user
- belongs_to: item
- has_one : pay_form