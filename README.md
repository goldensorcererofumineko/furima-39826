# README

## users テーブル

| Column              | Type   | Options                    |
| ------------------- | ------ | -------------------------- |
| email               | string | null: false, unique: true  |
| encrypted_password  | string | null: false                |
| nickname            | string | null: false                |
| last_name           | string | null: false                |
| first_name          | string | null: false                |
| last_name_kana      | string | null: false,               |
| first_name_kana     | string | null: false,               |
| birth_date          | date   | null: false                |

## items テーブル

| Column                       | Type       | Options                        |
| ---------------------------- | ---------- | ------------------------------ |
| item_name                    | string     | null: false                    |
| item_price                   | integer    | null: false                    |
| item_info                    | text       | null: false                    |
| item_category_id             | integer    | null: false                    |
| item_sales_status_id         | integer    | null: false                    |
| item_shipping_fee_status_id  | integer    | null: false                    |
| prefecture_id                | integer    | null: false                    |

## orders テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

## addresses テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | ------------------------------ |
| post-code      | string     | null: false, maxlength8        |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| addresses      | string     | null: false                    |
| building       | string     |                                |
| phone-number   | string     | null: false, length10~11       |
| orders         |references  | null: false, foreign_key: true |

## comments テーブル

| Column         | Type       | Options                        |
| ---------------| ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |
| text           | text       | null: false                    |