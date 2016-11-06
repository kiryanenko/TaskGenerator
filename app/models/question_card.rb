class QuestionCard < ApplicationRecord
  belongs_to :user
  has_many :generations
  has_many :variants, through: :generations
  has_many :generated_tasks, through: :variants

  before_destroy do
    unless self.generations.empty?
      self.update(removed: true)
      throw :abort
    end
  end
end
