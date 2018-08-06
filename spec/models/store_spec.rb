require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'associations and validations' do
    it { should have_many(:items) }
    it { should have_many(:item_stores) }
    it { should validate_presence_of(:name)}
  end

  context 'checking destruction' do

    it 'expect item_store to be destroyed when item is destroyed' do
      @item = FactoryBot.create(:item)
      @item_store = FactoryBot.create(:item_store, item_id: @item.id )
      expect { @item.destroy }.to change { ItemStore.count }.by(-1)
    end
  end
end
