class Store < ApplicationRecord
  has_and_belongs_to_many :items

  validates_presence_of :name
end
