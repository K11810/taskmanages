# README

## Repository name
  タスク管理アプリ<br>
  万葉新入社員教育用カリキュラム<br>
  <https://github.com/everyleaf/el-training>

## System dependencies
  ruby 2.6.3<br>
  rails 5.2.3<br>
  PostgreSQL 9.5.17<br>

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
| deadline | date | |
| priority | integer | |
| status | integer | |

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

<br>

## How to deploy the applications to Heroku
●1.Herokuにログインする。<br>
`heroku login --interactive`<br>
⇒Herokuに登録したメールアドレス、パスワードを入力<br>
<br>
●2.Herokuに新しいアプリケーションを作成する。<br>
`heroku create`<br>
⇒出力されたhttps:～/がアプリケーションのURLになる。<br>
<br>
●3.Herokuへgit pushを行う。<br>
`git push heroku master`<br>
<br>
●4.Heroku上のデータベースのマイグレーションを実行する。<br>
`heroku run rails db:migrate`
