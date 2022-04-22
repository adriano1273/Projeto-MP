require 'rails_helper'

RSpec.describe Genre, type: :model do

  describe 'Factory' do
    it { expect(build(:genre)).to be_valid }
  end
    
  describe 'validations' do
    context "when name is missing" do
      it { expect(build(:genre, name: nil)).to_not be_valid }
    end
  end

end
