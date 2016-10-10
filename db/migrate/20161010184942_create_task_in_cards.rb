class CreateTaskInCards < ActiveRecord::Migration[5.0]
  def change
    create_table :task_in_cards do |t|
      t.integer :card
      t.integer :task
      t.boolean :is_group

      t.timestamps
    end
  end
end
