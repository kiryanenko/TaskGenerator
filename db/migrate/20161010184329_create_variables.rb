class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.integer :task
      t.string :name
      t.integer :type
      t.float :from
      t.integer :dimension_from
      t.float :to
      t.integer :dimension_to

      t.timestamps
    end
  end
end
