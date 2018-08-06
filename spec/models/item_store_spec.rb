require 'rails_helper'

RSpec.describe ItemStore, type: :model do
  context 'associations and validations' do
    it { should belong_to(:item) }
    it { should belong_to(:store) }
  end
end