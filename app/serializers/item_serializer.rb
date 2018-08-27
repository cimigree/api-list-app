class ItemSerializer < ActiveModel::Serializer

  attributes :id,
    :name,
    :brand_name,
    :quantity,
    :coupon,
    :note,
    :purchased,
    :frequency,
    :category_name,
    :stores_names

    def category_name
      object.category.name
    end

    def stores_names
      object.stores.map(&:name)
    end
end
