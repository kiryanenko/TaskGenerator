class CreateGeneratedTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_tasks do |t|
      t.integer :task_id
      t.integer :task_in_card
      t.integer :variant_id

      t.timestamps
    end
  end
end
