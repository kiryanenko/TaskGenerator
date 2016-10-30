class AddColoumnToGeneration < ActiveRecord::Migration[5.0]
  def change
    change_table :generations do |t|
      t.boolean :orientation
    end
  end
end
