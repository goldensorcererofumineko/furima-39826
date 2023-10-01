# README

## users テーブル

| Column              | Type   | Options                    |
| ------------------- | ------ | -------------------------- |
| email               | string | null: false, unique: true  |
| encrypted_password  | string | null: false                |
| nickname            | string | null: false                |
| last_name           | string | null: false  漢字のみ       |
| first_name          | string | null: false  漢字のみ       |
| last_name_kana      | string | null: false, カナのみ       |
| first_name_kana     | string | null: false, カナのみ       |
| birth_date          | date   | null: false                |

## items テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| item_name                 | string     | null: false                    |
| item_price                | integer    | null: false                    |
| item_info                 | text       | null: false                    |
| item_category             | integer    | null: false                    |
| item_sales_status         | integer    | null: false                    |
| item_shipping_fee_status  | integer    | null: false                    |
| item_prefecture           | integer    | null: false                    |
| item_scheduled_delivery   | integer    | null: false                    |
| user                      | references | null: false, foreign_key: true |

## orders テーブル

| Column        | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| post-code     | strong     | null: false, maxlength8        |
| prefecture    | integer    | null: false                    |
| city          | string     | null: false                    |
| addresses     | string     | null: false                    |
| building      | string     |                                |
| phone-number  | string     | null: false, length10~11       |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

