class ChangeDefaultToTasks < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tasks, :removed, false
  end
end
