class CreateCalculatedVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :calculated_variables do |t|
      t.belongs_to :task, index: true
      t.string :name, null: false
      t.belongs_to :variable_type, index: true
      t.string :formula
    end
  end
end
