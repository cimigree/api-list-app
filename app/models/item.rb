class Item < ApplicationRecord
  has_many :item_stores
  has_many :stores, through: :item_stores, dependent: :destroy 
  belongs_to :category, optional: true

  accepts_nested_attributes_for :item_stores
  accepts_nested_attributes_for :stores

  validates_presence_of :name, :frequency
  # validates :frequency, inclusion: { in: %w(weekly, biweekly, monthly, as needed), message: "%{value} is not a valid frequency" }
  validates :purchased, inclusion: { in: [true, false] }, allow_blank: true
end
