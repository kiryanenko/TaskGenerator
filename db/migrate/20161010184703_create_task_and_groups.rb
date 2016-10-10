class CreateTaskAndGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :task_and_groups do |t|
      t.integer :task
      t.integer :group

      t.timestamps
    end
  end
end
