class QuestionCard < ApplicationRecord
  belongs_to :user
  has_many :generations
  has_many :variants, through: :generations
  has_many :generated_tasks, through: :variants
end
