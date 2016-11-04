class Generation < ApplicationRecord
  belongs_to :user
  belongs_to :question_card
  has_many :variants
end
