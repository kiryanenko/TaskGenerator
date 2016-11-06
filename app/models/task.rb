class Task < ApplicationRecord
  has_many :variables
  accepts_nested_attributes_for :variables
  belongs_to :user
  has_and_belongs_to_many :tasks_groups, join_table: 'tasks_and_groups'
  has_many :generated_tasks

  before_destroy do
    unless self.generated_tasks.empty? && self.tasks_groups.empty?
      self.update(removed: true)
      throw :abort
    end
  end
end
