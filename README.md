# README

## Repository name
  タスク管理アプリ
  万葉新入社員教育用カリキュラム <https://github.com/everyleaf/el-training>

## System dependencies
  ruby 2.6.3
  rails 5.2.3
  PostgreSQL 9.5.17

## Model
>### User Model

| Column | Type | Description |
| :--- | :--- | :--- |
| id | integer | |
| name | string | |
| email | string | |
| password_digest | string | |

>### Task Model

| Column | Type | Description |
| :--- | :--- | :--- |
| id | integer | |
| user_id | integer | foreign_key |
| title | string | |
| content | text | |
| deadline | datetime | |
| priority | string | |
| status | string | |

>### Task_label Model

| Column | Type | Description |
| :--- | :--- | :--- |
| id | integer | |
| task_id | integer | foreign_key |
| label_id | integer | foreign_key |

>### Label Model

| Column | Type | Description |
| :--- | :--- | :--- |
| id | integer | |
| name | string | |


## How to deploy the applications to Heroku
●1.Herokuにログインする。
    `heroku login --interactive`
    ⇒Herokuに登録したメールアドレス、パスワードを入力
●2.Herokuに新しいアプリケーションを作成する。
    `heroku create`
    ⇒出力されたhttps:～/がアプリケーションのURLになる。
●3.Herokuへgit pushを行う。
    `git push heroku master`
●4.Heroku上のデータベースのマイグレーションを実行する。
    `heroku run rails db:migrate`
