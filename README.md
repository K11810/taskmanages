# README

## Repository name
  タスク管理アプリ
  万葉新入社員教育用カリキュラム <https://github.com/everyleaf/el-training>

## System dependencies
  ruby 2.6.3
  rails 5.2.3
  PostgreSQL 9.5.17

## Database tables
  ◆Users table
  | Column | Type | Description |
  | :--- | :--- | :--- |
  | id | integer | |
  | name | string | |
  | email | string | |
  | password_digest | |

  ◆Tasks table
  | Column | Type | Description |
  | :--- | :--- | :--- |
  | id | integer | |
  | user_id | integer | foreign_key |
  | task-title | string | |
  | task-content | text | |
  | deadline | datetime | |
  | priority | string | |
  | status | string | |

  ◆Tags table
  | Column | Type | Description |
  | :--- | :--- | :--- |
  | id | integer | |
  | task_id | integer | foreign_key |
  | label_id | integer | foreign_key |

  ◆Labels table
  | Column | Type | Description |
  | :--- | :--- | :--- |
  | id | integer | |
  | label_name | string | |
