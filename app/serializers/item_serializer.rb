class ItemSerializer < ActiveModel::Serializer

  attributes :id,
    :name,
    :brand_name,
    :quantity,
    :coupon,
    :note,
    :purchased,
    :frequency,
    :store

    belongs_to :category

    def store
      Store.find(object.store_id)
    end
end
