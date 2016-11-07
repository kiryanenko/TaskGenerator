class CreateTasksGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks_groups do |t|
      t.belongs_to :user, index: true
      t.integer :subject
      t.string :title, null: false
      t.text :description, limit: 300
      t.boolean :removed, default: false, null: false

      t.timestamps
    end

    create_table :tasks_and_groups, id: false do |t|
      t.belongs_to :tasks_group, index: true, counter_cache: true
      t.belongs_to :task, index: true
    end
    # Добавление индекса уникальности на 2 столбца
    add_index :tasks_and_groups, [:tasks_group_id, :task_id], unique: true
  end
end
