class CreateCalculatedVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :calculated_variables do |t|
      t.belongs_to :tasks, index: true
      t.string :name
      t.belongs_to :variable_types, index: true
      t.string :formula
    end
  end
end
