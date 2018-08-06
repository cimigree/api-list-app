class Item < ApplicationRecord
  has_many :item_stores
  has_many :stores, through: :item_stores, dependent: :destroy 
  belongs_to :category, optional: true

  validates_presence_of :name, :frequency
  validates :purchased, inclusion: { in: [true, false] }
end