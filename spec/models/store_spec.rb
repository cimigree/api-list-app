require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should have_and_belong_to_many(:items) }
  it { should validate_presence_of(:name) }
end
