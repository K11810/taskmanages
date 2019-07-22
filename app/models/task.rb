class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..140 }
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  belongs_to :user

  enum status: {"未着手": 0, "着手中": 1, "完了": 2}
  enum priority:{"高": 0, "中": 1, "低": 2}

  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :sort_create, -> { order(created_at: :desc) }
  scope :sort_priority, -> { order(priority: :asc) }
  scope :search_title, -> (title){ where('title LIKE ?' , "%#{title}%") }
  scope :search_status, -> (params){ where(('CAST(status AS TEXT) LIKE ?'), "%#{ params }%") }

end
