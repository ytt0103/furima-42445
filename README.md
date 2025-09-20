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
- has_many :orders


## Items テーブル

| Column            | Type       | Options                                |
|-------------------|------------|----------------------------------------|
| name              | string     | null: false, foreign_key: true         |
| description       | text       | null: false, foreign_key: true         |
| price             | integer    | null: false, foreign_key: true         |
| user              | references | null: false, foreign_key: true         |
| category_id       | integer    | null: false                            |
| item_status_id    | integer    | null: false                            |
| shipping_fee_payer_id | integer | null: false                           |
| prefecture_id         | integer | null: false                           |
| delivery_day_id   | integer    | null: false                            |


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
| item       | references | null: false, foreign_key: true     |
| user       | references | null: false, foreign_key: true     |


### Association
- belongs_to :user
- belongs_to :item
- has_one :address

---

## Addresses テーブル

| Column         | Type     | Options                            |
|----------------|----------|------------------------------------|
| order          | references  | null: false, foreign_key: true     |
| postal_code    | string   | null: false                        |
| prefecture_id  | integer  | null: false                        |
| city           | string   | null: false                        |
| house_number   | string   | null: false                        |
| building_name  | string   |                                    |
| phone_number   | string   | null: false                        |


### Association
- belongs_to :order