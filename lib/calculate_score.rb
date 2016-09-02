class CalculateScore
  def initialize(player_shots)
    @shots = player_shots
    raise "Shots from multiple players" if @shots.map(&:player).uniq.size > 1
  end

  def calculate(shot)
    score = 0
    if shot.frame < 10 && shot.number == 1 && shot.pins == 10 && @shots.size > 1
      @subsequent_shots = @shots.select { |s| s.frame >= shot.frame }
      score = map_score(0..2) if shot.number == 1
    elsif @shots.size > 1
      @frame_shots = @shots.select { |s| s.frame == shot.frame }
      score = map_frame_shots
      if score == 10
        @subsequent_shots = @shots.select { |s| s.frame >= shot.frame }
        score = map_score(0..2)
      end
      score
    else
      score = shot.pins
    end
    score
  end

   private
   def map_frame_shots
     @frame_shots[0..2].map(&:pins).reduce(0, :+)
   end

   def map_score(range)
     @subsequent_shots[range].map(&:pins).reduce(0, :+)
   end
end
