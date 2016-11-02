class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variable_types do |t|
      t.string :type

      t.timestamps
    end

    create_table :dimensions do |t|
      t.belongs_to :variable_types, index: true
      t.integer :exponent
      t.string :dimension

      t.timestamps
    end

    create_table :variables do |t|
      t.belongs_to :tasks, index: true
      t.string :name
      t.belongs_to :variable_types, index: true
      t.float :from
      t.belongs_to :dimensions, foreign_key: 'dimension_from_id', index: true
      t.float :to
      t.belongs_to :dimensions, foreign_key: 'dimension_to_id', index: true
    end
  end
end
