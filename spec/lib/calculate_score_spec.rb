require 'rails_helper'

describe CalculateScore do
  let(:game) { FactoryGirl.create(:game) }
  let(:player) { 1 }
  let(:frame) { 1 }
  let(:pins) { 5 }
  let(:number) { 1 }
  let!(:shot) { FactoryGirl.create(:shot,
                                   frame: frame,
                                   game: game,
                                   player: player,
                                   pins: pins,
                                   number: number) }

  subject { described_class.new(game.shots.where(player: player)) }

  let(:expected_result) { pins }

  it 'calculates the score for a shot' do
    expect(subject.calculate(shot)).to eq(expected_result)
  end

  context 'when the shot was not a strike' do
    let(:pins) { 4 }
    let(:expected_result) { 4 }

    it 'calculates the score for a shot' do
      expect(subject.calculate(shot)).to eq(expected_result)
    end

    context 'when the second shot does not add up to a spare' do
      let(:second_pins) { 4 }
      let(:expected_result) { 8 }
      let!(:shot_two) { FactoryGirl.create(:shot,
                                           frame: frame,
                                           game: game,
                                           pins: second_pins,
                                           player: player,
                                           number: number) }

      it 'calculates the score for a shot' do
        expect(subject.calculate(shot)).to eq(expected_result)
      end
    end

    context 'when the second shot was a spare' do
      let(:second_pins) { 6 }
      let(:expected_result) { 10 }

      let!(:shot_two) { FactoryGirl.create(:shot,
                                           frame: frame,
                                           game: game,
                                           pins: second_pins,
                                           player: player,
                                           number: 2) }

      it 'calculates the score for a shot' do
        expect(subject.calculate(shot)).to eq(expected_result)
      end

      context 'and the next shot was a 5' do
        let!(:shot_three) { FactoryGirl.create(:shot,
                                               frame: 2,
                                               game: game,
                                               pins: 5,
                                               player: player,
                                               number: 1) }
        let(:expected_result) { 15 }

        it 'calculates the score for a shot' do
          expect(subject.calculate(shot)).to eq(expected_result)
        end
      end
    end
  end

  context 'when the shot was a strike' do
    let(:pins) { 10 }
    let(:expected_result) { 10 }

    it 'calculates the score for a shot' do
      expect(subject.calculate(shot)).to eq(expected_result)
    end

    context 'and the next shot was a 5' do
      let!(:shot_two) { FactoryGirl.create(:shot,
                                      game: game,
                                      pins: 5,
                                      player: player,
                                      frame: 2,
                                      number: number) }
      let(:expected_result) { 15 }

      it 'calculates the score for a shot' do
        expect(subject.calculate(shot)).to eq(expected_result)
      end

      context 'and the next score is 5' do
        let!(:shot_three) { FactoryGirl.create(:shot,
                                             game: game,
                                             pins: 5,
                                             frame: 2,
                                             player: player,
                                             number: number) }
        it 'calculates the score' do
          expect(subject.calculate(shot)).to eq(20)
        end
      end
    end


  end
end
