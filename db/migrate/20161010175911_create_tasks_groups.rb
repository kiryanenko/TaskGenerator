class CreateTasksGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks_groups do |t|
      t.integer :user
      t.integer :subject
      t.string :title
      t.text :description
      t.datetime :date
      t.boolean :removed

      t.timestamps
    end
  end
end
