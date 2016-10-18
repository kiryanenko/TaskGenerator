class ChangeVariables < ActiveRecord::Migration[5.0]
  def change
    change_table :variables do |t|
      t.rename :task, :task_id
    end
  end
end
