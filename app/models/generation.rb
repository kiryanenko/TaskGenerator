class Generation < ApplicationRecord
  belongs_to :user
  belongs_to :question_card
  has_many :variants, dependent: :destroy

  before_destroy do
    self.question_card.destroy if self.question_card.removed
  end
end
