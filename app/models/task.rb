class Task < ApplicationRecord
  has_many :variables
  accepts_nested_attributes_for :variables
  belongs_to :user
  has_and_belongs_to_many :tasks_groups, join_table: 'tasks_and_groups'
  has_many :generated_tasks

  def remove
    self.destroy unless if_linked { self.update(removed: true) }
  end

  def do_before_update
    if (task = if_linked { Task.create(self.attributes.merge({:id => nil})) }).nil?
      self
    else
      self.update(removed: true)
      task
    end
  end

  private
  def if_linked
    unless self.generated_tasks.empty? && self.tasks_groups.empty?
      yield
    end
  end
end
