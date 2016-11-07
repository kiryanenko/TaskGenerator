class MainPageController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  def index
    @tasks = current_user.tasks.where(removed: false).sort { |a, b| b.updated_at <=> a.updated_at }.take(5)
    @tasks_groups = current_user.tasks_groups.where(removed: false).sort { |a, b| b.updated_at <=> a.updated_at }.take(5)
    @generations = current_user.generations.sort { |a, b| b.updated_at <=> a.updated_at }.take(5)
    @question_cards = current_user.question_cards.where(removed: false).sort { |a, b| b.updated_at <=> a.updated_at }.take(5)
  end

  def welcome
  end
end
