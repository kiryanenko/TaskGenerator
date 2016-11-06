class Variant < ApplicationRecord
  belongs_to :generation
  has_many :generated_tasks, dependent: destroy
end
