class CreateGenerations < ActiveRecord::Migration[5.0]
  def change
    create_table :generations do |t|
      t.belongs_to :users, index: true
      t.belongs_to :question_cards, index: true

      t.timestamps
    end

    create_table :variants do |t|
      t.integer :number
      # Опция :counter_cache для того, чтобы поиск количества принадлежащих объектов был более эффективным
      t.belongs_to :generations, index: true, counter_cache: true
    end
  end
end
