class GeneratedTask < ApplicationRecord
  belongs_to :task
  belongs_to :variant
  has_many :generated_variables

  before_destroy do
    self.task.destroy if self.task.removed && self.task.tasks_groups.empty?
  end
end
