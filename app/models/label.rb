class Label < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 20 }

  has_many :task_labels
  has_many :tasks, through: :task_labels, source: :task

end
