class CreateQuestionCards < ActiveRecord::Migration[5.0]
  def change
    create_table :question_cards do |t|
      t.integer :user
      t.integer :subject
      t.string :title
      t.text :description
      t.text :question_card
      t.datetime :date
      t.boolean :removed

      t.timestamps
    end
  end
end
