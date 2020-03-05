# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| username | string | null: false |
| Email    | string | null: false |
| password | string | null: false |

### Association

- has_many :Messages
- has_many :groups
- has_many :groups, through: :groups_users

---

## groupsテーブル

| Column          | Type    | Options     |
| --------------- | ------- | ----------- |
| groupname       | text    | null: false |
| User_id         | integer | null: false |
| groups_users_id | integer | null: false |

### Association

- belongs_to :user
- has_many :message
- has_many :users, through: :groups_users

---

## groups_usersテーブル

| Column | Type  |           Options            |
|--------|-------|------------------------------|
|user_id |integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|



### Association

- belongs_to :user

- belongs_to :group

---

## Messagesテーブル

|  Column  |   Type  |            Options             |
| -------- | ------- | ------------------------------ |
|   text   |  text   |          null: false           |
|  image   |  text   |                                |
| user_id  | integer | null: false, foreign_key: true |
| group_id | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :group

---