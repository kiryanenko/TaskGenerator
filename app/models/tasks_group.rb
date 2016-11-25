class TasksGroup < ApplicationRecord
  include PgSearch

  belongs_to :user
  has_and_belongs_to_many :tasks, join_table: 'tasks_and_groups'

  validates :title, presence: true

  pg_search_scope :search, against: [:title, :description, :subject]

  before_destroy do
    self.tasks.each { |t| t.destroy if t.removed && t.generated_tasks.empty? }
  end

  def remove
    self.destroy unless if_linked { self.update(removed: true) }
  end

  def do_before_update
    if (group = if_linked { self.create_copy }).nil?
      self
    else
      self.update(removed: true)
      group
    end
  end

  def create_copy
    g = TasksGroup.new(self.attributes.merge({:id => nil}))
    g.transaction do
      g.save!
      self.tasks.each { |t| g.tasks.create!(t.attributes.merge({:id => nil})) }
    end
    return g
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
