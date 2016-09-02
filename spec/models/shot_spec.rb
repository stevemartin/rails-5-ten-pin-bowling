require 'rails_helper'

RSpec.describe Shot, type: :model do
  context 'when valid' do
    let(:game) { FactoryGirl.create(:game) }
    it 'can be persisted' do
      expect( described_class.new(game: game,
                                  frame: 1,
                                  number: 1,
                                  player: 1,
                                  pins: 10) ).to be_valid
    end
  end

  context 'when invalid' do
    it 'cannot be persisted' do
      expect( described_class.new() ).to be_invalid
    end
  end
end
