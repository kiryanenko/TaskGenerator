class GeneratedTask < ApplicationRecord
  belongs_to :task
  belongs_to :variant

  before_destroy do
    self.task.destroy if self.task.removed && self.task.tasks_groups.empty?
  end
end
