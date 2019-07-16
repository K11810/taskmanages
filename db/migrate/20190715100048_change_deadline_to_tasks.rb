class ChangeDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :datetime, null: false, default: DateTime.now
  end
end
