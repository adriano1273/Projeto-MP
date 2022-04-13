# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    context 'when using factory bot' do
      it { expect(build(:user)).to be_valid }
    end
  end

  describe 'validations' do
    it 'with missing email' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'with missing password' do
      expect(build(:user, password: nil)).to_not be_valid
    end

    it 'with missing name' do
      expect(build(:user, name: nil)).to_not be_valid
    end

    context 'for is_admin field' do
      it { expect(build(:user, is_admin: true)).to be_valid }
      it { expect(build(:user, is_admin: false)).to be_valid }
      it { expect(build(:user, is_admin: nil)).to_not be_valid }
    end
  end
end
