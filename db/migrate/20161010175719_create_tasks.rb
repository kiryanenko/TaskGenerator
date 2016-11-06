class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.string :title, null: false
      t.text :description, limit: 300
      t.text :task, null: false
      t.text :answer
      t.integer :subject
      t.boolean :removed, default: false, null: false

      t.timestamps
    end
  end
end
