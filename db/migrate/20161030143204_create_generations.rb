class CreateGenerations < ActiveRecord::Migration[5.0]
  def change
    create_table :generations do |t|
      t.integer :user_id
      t.integer :question_card_id
      t.integer :page_layout_id

      t.timestamps
    end
  end
end
