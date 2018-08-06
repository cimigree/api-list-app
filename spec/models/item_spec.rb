require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'associations and validations' do
    it { should belong_to(:category) }
    it { should have_many(:item_stores) }
    it { should have_many(:stores) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:frequency) }
    it { should validate_inclusion_of(:purchased).in_array([true, false]) }
  end

  context 'checking destruction' do

    it 'expect item_store to be destroyed when item is destroyed' do
      @store = FactoryBot.create(:store)
      @item_store = FactoryBot.create(:item_store, store_id: @store.id )
      expect { @store.destroy }.to change { ItemStore.count }.by(-1)
    end
  end
end
