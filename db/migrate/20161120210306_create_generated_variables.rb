class CreateGeneratedVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :generated_variables do |t|
      t.belongs_to :generated_task, index: true
      t.belongs_to :variable, index: true
      t.float :value, null: false
    end
  end
end
