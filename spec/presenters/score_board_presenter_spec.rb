require 'rails_helper'

describe ScoreBoardPresenter do

  let(:game) { FactoryGirl.create(:game, players: 1) }
  let(:cell) { { 1 => nil, 2 => nil, :total => nil } }
  let(:player_row) {
    [[], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], nil]
  }

  subject { described_class.new(game) }
  let(:scoreboard) do
    [
      player_row
    ]
  end

  it 'should build the scoreboard' do
    expect(subject.scoreboard).to eq(scoreboard)
  end

  context 'with two players' do
    let(:game) { FactoryGirl.create(:game, players: 2) }
    subject { described_class.new(game) }
    let(:scoreboard) do
      [ player_row, player_row ]
    end

    it 'should build the scoreboard' do
      expect(subject.scoreboard).to eq(scoreboard)
    end

    context 'when the first player has taken a shot' do
      let!(:shot) { FactoryGirl.create(:shot, game: game, player: 1, pins: 5, frame: 1, number: 1) }
      let(:first_row) {
        [
          [], [5, 5, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], 5
        ]
      }

      let(:scoreboard) do
        [
          first_row,
          [
            [], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], nil
          ]
        ]
      end

      it 'should build the scoreboard' do
        expect(subject.scoreboard[0]).to eq(first_row)
      end

      context 'and then a spare' do
        let!(:shot_two) { FactoryGirl.create(:shot, game: game, player: 1, pins: 5, frame: 1, number: 2) }

        let(:first_row) {
          [
            [], [10, 5, 5], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], 10
          ]
        }

        it 'should build the scoreboard' do
          expect(subject.scoreboard[0]).to eq(first_row)
        end

        context 'and then a strike' do
          let!(:shot_three) { FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: 2, number: 1) }

          let(:first_row) {
            [
              [], [20, 5, 5], [10, 10, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], 30
            ]
          }

          it 'should build the scoreboard' do
            expect(subject.scoreboard[0]).to eq(first_row)
          end


          context 'and then a strike' do
            let!(:shot_four) { FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: 3, number: 1) }

            let(:first_row) {
              [
                [], [20, 5, 5], [20, 10, nil], [10, 10, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], 50
              ]
            }

            it 'should build the scoreboard' do
              expect(subject.scoreboard[0]).to eq(first_row)
            end

          end
        end
      end
    end
  end

  context 'when the player has scored a turkey' do
    before do
      frame = 0
      9.times do |i|
        frame += 1
        FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: frame, number: 1)
      end
      FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: 10, number: 1)
      FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: 10, number: 2)
      FactoryGirl.create(:shot, game: game, player: 1, pins: 10, frame: 10, number: 3)
    end

    let(:first_row) {
      [
        [], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, nil], [30, 10, 10, 10], 300
      ]
    }

    it 'final score should be 300' do
      expect(subject.scoreboard[0]).to eq(first_row)
    end
  end
end
