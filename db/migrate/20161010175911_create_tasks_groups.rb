class CreateTasksGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks_groups do |t|
      t.belongs_to :user, index: true
      t.integer :subject
      t.string :title, null: false
      t.text :description
      t.boolean :removed, default: false, null: false

      t.timestamps
    end

    create_table :tasks_groups_tasks, id: false do |t|
      t.belongs_to :tasks_group, index: true
      t.belongs_to :task, index: true
    end
  end
end
