class Task < ApplicationRecord
  #include Bootsy::Container
  has_many :variables
  accepts_nested_attributes_for :variables
  belongs_to :user
end
