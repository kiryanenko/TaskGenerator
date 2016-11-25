class CalculatedVariable < ApplicationRecord
  belongs_to :task
  validates :name, format: { with: /\A\w+\Z/, message: 'Не верное имя переменной' }
end
