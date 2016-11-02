class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :users, index: true
      t.string :title
      t.text :description
      t.text :task
      t.text :answer
      t.integer :subject
      t.boolean :removed, default: false

      t.timestamps
    end
  end
end
