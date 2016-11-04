class TasksGroup < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks, join_table: 'tasks_and_groups'
end
