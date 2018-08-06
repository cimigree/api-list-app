class ItemStore < ApplicationRecord
  belongs_to :store
  belongs_to :item

  validates :store_id, presence: { message: 'Select store' }
  validates :item_id, presence: { message: 'Select item'}

end