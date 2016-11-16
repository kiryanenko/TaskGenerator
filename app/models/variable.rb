class Variable < ApplicationRecord
  belongs_to :task
  has_one :variable_type
  has_one :dimension_from, class_name: 'Dimension'
  has_one :dimension_to, class_name: 'Dimension'
end
