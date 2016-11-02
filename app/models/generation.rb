class Generation < ApplicationRecord
  def user
    return User.find(user_id)
  end
end
