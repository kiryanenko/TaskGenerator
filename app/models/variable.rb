class Variable < ApplicationRecord
  belongs_to :task
  validates :name, format: { with: /\A\w+\Z/, message: 'Не верное имя переменной' }
  validates_each :from, :to do |record, attr, value|
    record.errors.add(attr, 'Верхняя граница должна быть больше чем нижния') unless record.from <= record.to
  end
  validates_each :round do |record, attr, value|
    record.errors.add(attr, 'Округление должно быть больше или равно 0') unless value.nil? or value >= 0
  end
end
