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

>### Tag Model

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
