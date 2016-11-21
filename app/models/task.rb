class Task < ApplicationRecord
  include PgSearch

  has_many :variables
  has_many :calculated_variables
  accepts_nested_attributes_for :variables, reject_if: lambda { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :calculated_variables, reject_if: lambda { |attributes| attributes['name'].blank? }
  belongs_to :user
  has_and_belongs_to_many :tasks_groups, join_table: 'tasks_and_groups'
  has_many :generated_tasks

  pg_search_scope :search, against: [:title, :description, :subject, :task, :answer]

  def remove
    self.destroy unless if_linked { self.update(removed: true) }
  end

  def do_before_update
    if (task = if_linked { self.create_copy }).nil?
      self
    else
      self.update(removed: true)
      task
    end
  end

  def create_copy
    task = Task.new(self.attributes.merge({:id => nil}))
    task.transaction do
      task.save!
      self.variables.each { |v| task.variables.create!(v.attributes.merge({:id => nil})) }
      self.calculated_variables.each { |v| task.calculated_variables.create!(v.attributes.merge({:id => nil})) }
    end
    return task
  end

  private
  def if_linked
    unless self.generated_tasks.empty? && self.tasks_groups.empty?
      yield
    end
  end
end
