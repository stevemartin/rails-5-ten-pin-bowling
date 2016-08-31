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
      @shot_number = 2
      @strike = ten_pins_down?
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
    tenth_frame? && @strike && @last_shot.number < 4
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

=begin
  if last_shot.number == 2
    session[:player] += 1

    if last_shot.player == @game.players
      session[:frame] += 1
    end

  end
  if last_shot.frame == 10
    session[:frame] += 1
  end
  session[:player]
  session[:shot] = shot.number
=end
