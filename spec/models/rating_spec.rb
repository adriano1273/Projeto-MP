require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:rating)).to be_valid }
    end
  end
  describe 'validations' do
    context 'when rating value is more than 5' do
      it { expect(build(:rating, value: 7)).not_to be_valid }
    end
    context 'when rating value is lower than 5' do
      it { expect(build(:rating, value: 3)).to be_valid }
    end
  end
end
