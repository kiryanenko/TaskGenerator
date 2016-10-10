class CreateGeneratedTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_tasks do |t|
      t.integer :variant
      t.integer :task

      t.timestamps
    end
  end
end
