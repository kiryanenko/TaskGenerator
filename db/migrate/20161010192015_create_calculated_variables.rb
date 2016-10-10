class CreateCalculatedVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :calculated_variables do |t|
      t.integer :task
      t.string :name
      t.integer :type
      t.string :formula

      t.timestamps
    end
  end
end
