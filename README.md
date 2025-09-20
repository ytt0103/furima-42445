# テーブル設計

## Users テーブル

| Column              | Type     | Options                   |
|---------------------|----------|---------------------------|
| nickname            | string   | null: false               |
| email               | string   | null: false, unique: true |
| encrypted_password  | string   | null: false               |
| last_name           | string   | null: false               |
| first_name          | string   | null: false               |
| last_name_kana      | string   | null: false               |
| first_name_kana     | string   | null: false               |
| birth_date          | date     | null: false               |


### Association
- has_many :items

---

## Items テーブル

| Column            | Type       | Options                                |
|-------------------|------------|----------------------------------------|
| name              | string     | null: false                            |
| description       | text       | null: false                            |
| price             | integer    | null: false                            |
| user_id           | integer    | null: false, foreign_key: true         |
| category_id       | integer    | null: false, foreign_key: true         |
| item_status_id    | integer    | null: false, foreign_key: true         |
| shipping_fee_payer_id | integer | null: false, foreign_key: true         |
| prefecture_id         | integer    | null: false, foreign_key: true         |
| delivery_day_id   | integer    | null: false, foreign_key: true         |
| created_at        | datetime   | null: false                            |
| updated_at        | datetime   | null: false                            |

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :item_status
- belongs_to :shipping_fee_payer
- belongs_to :delivery_day
- has_one_attached :image

## Orders テーブル

| Column     | Type     | Options                            |
|------------|----------|------------------------------------|
| item_id    | integer  | null: false, foreign_key: true     |
| user_id    | integer  | null: false, foreign_key: true     |
| created_at | datetime | null: false                        |
| updated_at | datetime | null: false                        |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

## Addresses テーブル

| Column         | Type     | Options                            |
|----------------|----------|------------------------------------|
| order_id       | integer  | null: false, foreign_key: true     |
| postal_code    | string   | null: false                        |
| prefecture_id  | integer  | null: false                        |
| city           | string   | null: false                        |
| house_number   | string   | null: false                        |
| building_name  | string   |                                    |
| phone_number   | string   | null: false                        |
| created_at     | datetime | null: false                        |
| updated_at     | datetime | null: false                        |

### Association
- belongs_to :order