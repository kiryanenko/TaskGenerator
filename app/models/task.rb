class Task < ApplicationRecord
  #include Bootsy::Container
  has_many :variables
  accepts_nested_attributes_for :variables
  belongs_to :user
  has_and_belongs_to_many :tasks_groups, join_table: 'tasks_and_groups'
end
