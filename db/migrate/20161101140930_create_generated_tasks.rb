class CreateGeneratedTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_tasks do |t|
      t.belongs_to :tasks, index: true
      t.integer :task_in_card
      t.belongs_to :variants, index: true
    end
  end
end
