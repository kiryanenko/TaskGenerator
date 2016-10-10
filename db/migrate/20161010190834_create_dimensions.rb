class CreateDimensions < ActiveRecord::Migration[5.0]
  def change
    create_table :dimensions do |t|
      t.integer :variable_type
      t.integer :exponent
      t.string :dimension

      t.timestamps
    end
  end
end
