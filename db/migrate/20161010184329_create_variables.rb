class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variable_types do |t|
      t.string :type, null: false

      t.timestamps
    end

    create_table :dimensions do |t|
      t.belongs_to :variable_type, index: true
      t.integer :exponent, null: false
      t.string :dimension, null: false

      t.timestamps
    end

    create_table :variables do |t|
      t.belongs_to :task, index: true
      t.string :name, null: false
      t.belongs_to :variable_type, index: true
      t.float :from
      t.belongs_to :dimension_from, index: true
      t.float :to
      t.belongs_to :dimension_to, index: true
    end
  end
end
