class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.belongs_to :task, index: true
      t.string :name, null: false
      t.float :from, null: false
      t.float :to, null: false
      t.integer :round
    end
  end
end
