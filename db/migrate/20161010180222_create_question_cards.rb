class CreateQuestionCards < ActiveRecord::Migration[5.0]
  def change
    create_table :question_cards do |t|
      t.belongs_to :users, index: true
      t.integer :subject
      t.string :title
      t.text :description
      t.text :question_card
      t.boolean :removed, default: false

      t.timestamps
    end
  end
end
