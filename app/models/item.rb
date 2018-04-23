class Item < ApplicationRecord
  has_and_belongs_to_many :stores
  belongs_to :category

  validates_presence_of :name, :frequency
  validates :purchased, inclusion: { in: [true, false] }
end