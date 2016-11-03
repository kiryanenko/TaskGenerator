class CreateGeneratedTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_tasks do |t|
      t.belongs_to :task, index: true
      t.integer :task_in_card, null: false
      t.belongs_to :variant, index: true
    end
  end
end
