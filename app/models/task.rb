class Task < ApplicationRecord
  #include Bootsy::Container
  has_many :variables
  accepts_nested_attributes_for :variables
  def get_user
    return User.find(user)
  end
end
