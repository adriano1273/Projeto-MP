require 'rails_helper'

RSpec.describe Music, type: :model do
  context 'check name' do 
    it 'when the name is ok' do
      music = build(:music)
      expect(music).to be_valid
    end

    it 'when the name is not ok' do
      music = build(:music, title:nil)
      expect(music).to_not be_valid
    end
  end
end