class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :user
      t.string :title
      t.text :description
      t.text :task
      t.text :answer
      t.integer :subject
      t.datetime :date
      t.boolean :removed

      t.timestamps
    end
  end
end
