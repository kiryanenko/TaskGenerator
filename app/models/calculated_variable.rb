class CalculatedVariable < ApplicationRecord
  belongs_to :task
  validates :name, format: { with: /^\w+$/, message: 'Не верное имя переменной' }
end
