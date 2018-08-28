class StoreSerializer < ActiveModel::Serializer

  attributes :id,
    :name,
    :items

    has_many :items
end