class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.belongs_to :task, index: true
      t.string :name, null: false
      t.string :from, null: false
      t.string :to, null: false
    end
  end
end
