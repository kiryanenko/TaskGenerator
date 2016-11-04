class CreateQuestionCards < ActiveRecord::Migration[5.0]
  def change
    create_table :question_cards do |t|
      t.belongs_to :user, index: true
      t.integer :subject
      t.string :title, null: false
      t.text :description
      t.text :question_card, null: false, default: '<h1>Вариант № $V</h1><p>Текст билета</p>'
      t.boolean :removed, default: false

      t.timestamps
    end
  end
end
