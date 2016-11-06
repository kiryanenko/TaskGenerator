class TasksGroup < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks, join_table: 'tasks_and_groups'

  before_destroy do
    self.tasks.each { |t| t.destroy if t.removed }

    if QuestionCard.all.any? do |card|
      Nokogiri::HTML(card.question_card).css('.task').any? { |t| t[:tasks_group_id].to_i == self.id }
    end
      self.update(removed: true)
      throw :abort
    end
  end
end
