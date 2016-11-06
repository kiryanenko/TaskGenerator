class TasksGroup < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks, join_table: 'tasks_and_groups'

  before_destroy do
    self.tasks.each { |t| t.destroy if t.removed && t.generated_tasks.empty? }
  end

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
    if QuestionCard.all.any? do |card|
      Nokogiri::HTML(card.question_card).css('.task').any? { |t| t[:tasks_group_id].to_i == self.id }
    end
      yield
    end
  end
end
