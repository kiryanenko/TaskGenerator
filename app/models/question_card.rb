class QuestionCard < ApplicationRecord
  belongs_to :user
  has_many :generations
  has_many :variants, through: :generations
  has_many :generated_tasks, through: :variants

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
    unless self.generations.empty?
      yield
    end
  end
end
