class Variant < ApplicationRecord
  belongs_to :generation
  belongs_to :generated_task
end
