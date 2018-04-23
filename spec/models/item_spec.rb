require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:frequency) }
  it { is_expected.to have_and_belong_to_many(:stores) }
  it { is_expected.to validate_inclusion_of(:purchased).in_array([true, false]) }
end
