require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'can have up to four players' do
    game = FactoryGirl.build(:game, players: 4)
    expect(game).to be_valid
  end

  it 'cannot have more than four players' do
    game = FactoryGirl.build(:game, players: 5)
    expect(game).to_not be_valid
  end
end
