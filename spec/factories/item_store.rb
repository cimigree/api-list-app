FactoryBot.define do
  factory :item_store do
    before(:create) do |item_store|
      item_store.store_id = FactoryBot.create(:store).id if item_store.store.blank?
      item_store.item_id = FactoryBot.create(:item).id if item_store.item_id.blank?
    end
  end
end
