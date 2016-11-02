class TasksGroup < ApplicationRecord
  def get_user
    return User.find(user)
  end
end
