class ItemSerializer < ActiveModel::Serializer

  attributes :id,
    :name,
    :brand_name,
    :quantity,
    :coupon,
    :note,
    :purchased,
    :frequency,
    :category,
    :stores_names

    def stores_names
      object.stores.map(&:name)
    end
end
