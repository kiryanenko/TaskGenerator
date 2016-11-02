class CreateTasksGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks_groups do |t|
      t.belongs_to :users, index: true
      t.integer :subject
      t.string :title
      t.text :description
      t.boolean :removed, default: false

      t.timestamps
    end

    create_table :tasks_groups_tasks, id: false do |t|
      t.belongs_to :tasks_groups, index: true
      t.belongs_to :tasks, index: true
    end
  end
end
