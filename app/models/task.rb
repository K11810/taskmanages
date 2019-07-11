class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..140 }
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true

  enum status: {"未着手": 0, "着手中": 1, "完了": 2}

  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :sort_create, -> { order(created_at: :desc) }
  scope :search_title, -> (title){ where('title LIKE ?' , "%#{title}%") }
  scope :search_status, -> (params){ where(('CAST(status AS TEXT) LIKE ?'), "%#{ params }%") }

end
