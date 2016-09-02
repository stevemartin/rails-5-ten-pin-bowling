require 'rails_helper'

describe GameEngine do
  let(:session)   { {} }
  let(:game)      { FactoryGirl.create(:game) }
  let(:last_shot) { FactoryGirl.create(:shot,
                                       player: player,
                                       frame: frame,
                                       number: number,
                                       pins: pins,
                                       game: game) }

  subject         { described_class.new(game, session) }

  context 'on initialize' do
    it 'sets initial variables to 1' do
      expect(subject.status[:player]).to eq(1)
      expect(subject.status[:frame]).to eq(1)
      expect(subject.status[:shot_number]).to eq(1)
    end
  end

  context 'when the player has had a shot' do
    let(:player) { 1 }
    let(:frame) { 1 }
    let(:number) { 1 }
    let(:pins) { 9 }

    it 'moves to the second shot' do
      subject.update(last_shot)
      expect(subject.status[:player]).to eq(1)
      expect(subject.status[:frame]).to eq(1)
      expect(subject.status[:shot_number]).to eq(2)
    end

    context 'and scored a strike' do
      let(:pins) { 10 }
      it 'moves to the next frame' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(1)
        expect(subject.status[:frame]).to eq(2)
        expect(subject.status[:shot_number]).to eq(1)
      end
    end
  end

  context 'when there are two players' do
    let(:game) { FactoryGirl.create(:game, players: 2) }

    context 'when the player has had two shots' do
      let(:player) { 1 }
      let(:frame) { 1 }
      let(:number) { 2 }
      let(:pins) { 10 }

      it 'updates the player' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(2)
        expect(subject.status[:frame]).to eq(1)
        expect(subject.status[:shot_number]).to eq(1)
      end
    end

    context 'when the second player has had a shot' do
      let(:player) { 2 }
      let(:frame) { 1 }
      let(:number) { 1 }
      let(:pins) { 9 }

      it 'updates the shot' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(2)
        expect(subject.status[:frame]).to eq(1)
        expect(subject.status[:shot_number]).to eq(2)
      end
    end

    context 'when the second player has had second shot and there are only two players' do
      let(:player) { 2 }
      let(:frame) { 1 }
      let(:number) { 2 }
      let(:pins) { 9 }

      it 'updates the frame' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(1)
        expect(subject.status[:frame]).to eq(2)
        expect(subject.status[:shot_number]).to eq(1)
      end
    end

    context 'when the game reaches the ninth frame' do
      let(:player) { 2 }
      let(:frame) { 9 }
      let(:number) { 2 }
      let(:pins) { 9 }

      it 'updates to the shot' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(1)
        expect(subject.status[:frame]).to eq(10)
        expect(subject.status[:shot_number]).to eq(1)
      end
    end

    context 'when the player scores a strike in the tenth frame' do
      let(:session)   { { strike: true, spare: true } }
      let(:player) { 1 }
      let(:frame) { 10 }
      let(:number) { 1 }
      let(:pins) { 10 }

      it 'updates to the shot' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(1)
        expect(subject.status[:frame]).to eq(10)
        expect(subject.status[:shot_number]).to eq(2)
        expect(subject.status[:strike]).to eq(true)
      end

      context 'and she takes her second shot' do
        let(:player) { 1 }
        let(:frame) { 10 }
        let(:number) { 2 }
        let(:pins) { 10 }

        it 'she can take a third shot' do
          subject.update(last_shot)
          expect(subject.status[:player]).to eq(1)
          expect(subject.status[:frame]).to eq(10)
          expect(subject.status[:shot_number]).to eq(3)
        end

      end
    end

    context 'when the last player scores a strike in the tenth frame' do
      let(:session) { { strike: true, spare: true } }
      let(:player)  { 2 }
      let(:frame)   { 10 }
      let(:number)  { 1 }
      let(:pins)    { 10 }

      it 'updates to the shot' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(2)
        expect(subject.status[:frame]).to eq(10)
        expect(subject.status[:shot_number]).to eq(2)
        expect(subject.status[:strike]).to eq(true)
      end

      context 'and she takes her second shot' do
        let(:player) { 2 }
        let(:frame) { 10 }
        let(:number) { 2 }
        let(:pins) { 10 }

        it 'she can take a third shot' do
          subject.update(last_shot)
          expect(subject.status[:player]).to eq(2)
          expect(subject.status[:frame]).to eq(10)
          expect(subject.status[:shot_number]).to eq(3)
        end

      end
    end

    context 'when the player scores a spare in the tenth frame' do
      let(:session)   { { strike: false, spare: true } }
      let(:player) { 1 }
      let(:frame) { 10 }
      let(:number) { 2 }
      let(:pins) { 8 }

      let!(:first_shot) { FactoryGirl.create(:shot,
                                           player: player,
                                           frame: frame,
                                           number: 1,
                                           pins: 2,
                                           game: game) }

      it 'updates to the shot' do
        subject.update(last_shot)
        expect(subject.status[:player]).to eq(1)
        expect(subject.status[:frame]).to eq(10)
        expect(subject.status[:shot_number]).to eq(3)
        expect(subject.status[:strike]).to eq(false)
        expect(subject.status[:spare]).to eq(true)
      end

      context 'and she takes her third shot' do
        let(:player) { 1 }
        let(:frame) { 10 }
        let(:number) { 3 }
        let(:pins) { 10 }

        let!(:third_shot) { FactoryGirl.create(:shot,
                                             player: player,
                                             frame: frame,
                                             number: 3,
                                             pins: 2,
                                             game: game) }

        it 'moves to the next player' do
          last_shot
          subject.update(third_shot)
          expect(subject.status[:player]).to eq(2)
          expect(subject.status[:frame]).to eq(10)
          expect(subject.status[:shot_number]).to eq(1)
        end

      end
    end

    context 'when the last player scores a spare in the tenth frame' do
      let(:player) { 2 }
      let(:frame) { 10 }
      let(:number) { 3 }
      let(:pins) { 10 }

      let!(:first_shot) { FactoryGirl.create(:shot,
                                           player: player,
                                           frame: frame,
                                           number: 1,
                                           pins: 2,
                                           game: game) }
      let!(:third_shot) { FactoryGirl.create(:shot,
                                             player: player,
                                             frame: frame,
                                             number: 3,
                                             pins: 2,
                                             game: game) }
      context 'and she takes her third shot' do
        it 'the game resets' do
          subject.update(third_shot)
          expect(subject.status[:game_over]).to eq(true)
          # expect(subject.status[:player]).to eq(1)
          # expect(subject.status[:frame]).to eq(1)
          # expect(subject.status[:shot_number]).to eq(1)
          # expect(subject.status[:strike]).to eq(false)
          # expect(subject.status[:spare]).to eq(false)
        end
      end
    end

    context 'when the last player has taken their last shot' do
      it 'ends the game' do

      end
    end
  end

end
