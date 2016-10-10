class CreateGeneratedVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_variables do |t|
      t.integer :generated_task
      t.integer :variable
      t.float :value

      t.timestamps
    end
  end
end
