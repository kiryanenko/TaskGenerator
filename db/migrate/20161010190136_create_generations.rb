class CreateGenerations < ActiveRecord::Migration[5.0]
  def change
    create_table :generations do |t|
      t.integer :user
      t.integer :task
      t.integer :page_layout

      t.timestamps
    end
  end
end
