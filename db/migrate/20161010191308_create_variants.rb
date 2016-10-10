class CreateVariants < ActiveRecord::Migration[5.0]
  def change
    create_table :variants do |t|
      t.integer :number
      t.integer :generation

      t.timestamps
    end
  end
end
