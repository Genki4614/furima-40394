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
| birthday           | string | null: false |

### Association
- has_many :items
- has_many :purchase_records
- has_many :pay_forms

## itemsレコード
|Column               |Type    | Options     |
|---------------------|--------|-------------|
| item's name         | string | null: false |
| categories          | string | null: false |
| sale_status         | string | null: false |
| shipping_fee_status | string | null: false |
| prefecture          | string | null: false |
| scheduled_deliver   | string | null: false |
| sell_price          | integer| null: false |
| sell_tax_price      | integer|
| profit              | integer|

### Association
- belongs_to :users
- has_one :pay_forms
- has_one :purchase_records

## pay_forms レコード
|Column               |Type    | Options     |
|---------------------|--------|-------------|
| postal_code         | integer| null: false |
| prefecture          | string | null: false |
| city                | string | null: false |
| addresses           | string | null: false |
| building            | string |
| phone_number        | string | null: false |
| user                | references | foreign_key: true |
| item                | references | foreign_key: true |

### Association
- belongs_to : users
- belongs_to : items

## purchase_records
|Column               |Type    | Options     |
|---------------------|--------|-------------|
| user         | references| foreign_key: true |
| item         | references| foreign_key: true |

### Association
- belongs_to: users
- belongs_to: items