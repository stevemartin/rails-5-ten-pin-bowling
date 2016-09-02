class GameEngine
  attr_reader :player, :frame, :shot_number
  def initialize(game, session)
    @game   = game
    @player = 1
    @frame  = 1
    @shot_number = 1
    @strike = session[:strike] || false
    @spare  = session[:spare] || false
  end

  def status
    { player: @player, frame: @frame, shot_number: @shot_number, strike: @strike, spare: @spare }
  end

  def update(last_shot)
    @last_shot = last_shot

    @player = last_shot.player
    @frame = last_shot.frame
    @shot_number = last_shot.number

    if first_shot?
      if !tenth_frame? && @strike = ten_pins_down?
        @shot_number = 1
        if last_player?
          @player = 1
          @frame += 1
        else
          @player += 1
        end
      else
        @shot_number = 2
      end
    else
      if in_tenth_strike? || in_tenth_spare?
        @shot_number += 1
      elsif tenth_frame_ended?
        @frame = 1
        @shot_number = 1
        @player = 1
        @strike = false
        @spare = false
      else
        @shot_number = 1
        @player += 1
        @spare = ten_pins_down?
      end
    end

    if standard_frame_ended?
      @frame += 1
      @player = 1
    end
  end

  private
  def standard_frame_ended?
    @last_shot.number == 2 && last_player? && !tenth_frame?
  end

  def tenth_frame_ended?
    tenth_frame? && last_player? && !@strike && !@spare
  end

  def in_tenth_strike?
    tenth_frame? && @strike && @last_shot.number < 3
  end

  def in_tenth_spare?
     tenth_frame? && @spare && @last_shot.number < 3
  end

  def last_player?
    @last_shot.player == @game.players
  end

  def first_shot?
    @last_shot.number == 1
  end

  def ten_pins_down?
    @last_shot.pins == 10
  end

  def tenth_frame?
    @last_shot.frame == 10
  end
end
