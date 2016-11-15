class Variable < ApplicationRecord
  belongs_to :task
  has_one :variable_type
end
