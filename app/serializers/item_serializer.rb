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
    :stores

end
