class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, limit: 140
  end
end
