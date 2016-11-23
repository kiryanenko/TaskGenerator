class QuestionCard < ApplicationRecord
  include PgSearch

  belongs_to :user
  has_many :generations
  has_many :variants, through: :generations
  has_many :generated_tasks, through: :variants

  pg_search_scope :search, against: [:title, :description, :subject, :question_card]

  def remove
    self.destroy unless if_linked { self.update(removed: true) }
  end

  def do_before_update
    if (card = if_linked { self.create_copy }).nil?
      self
    else
      self.update(removed: true)
      card
    end
  end

  def create_copy
    return QuestionCard.new(self.attributes.merge({:id => nil}))
  end

  private
  def if_linked
    unless self.generations.empty?
      yield
    end
  end
end
