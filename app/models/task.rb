class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..140 }
  validates :content, presence: true
end
