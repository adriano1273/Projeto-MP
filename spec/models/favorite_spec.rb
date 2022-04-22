require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'Factory' do
    before do
      create(:user, id: 1)
      create(:music, id: 1)
    end
    it { expect(build(:favorite)).to be_valid }
  end

  describe 'validations' do
    context "when value is missing" do
      it { expect(build(:favorite, value: nil)).to_not be_valid }
    end
    context "when user reference" do
      it { expect(build(:favorite, user_id: nil)).to_not be_valid }
    end
    context "when music reference" do
      it { expect(build(:favorite, music_id: nil)).to_not be_valid }
    end
  end
end
