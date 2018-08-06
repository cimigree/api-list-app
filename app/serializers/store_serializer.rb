class StoreSerializer < ActiveModel::Serializer

  attributes :id,
    :name

  has_many :items, serializer: ItemSerializer
end