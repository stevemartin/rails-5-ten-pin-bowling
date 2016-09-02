class RunningScore
  attr_reader :score, :total_score
  def initialize(calculator)
    @calculator = calculator
    @total_score = 0
  end

  def accumulate(frame, shot)
    @score = 0
    if frame == 10
      @total_score += shot.pins
    elsif ( shot.number == 1 && shot.pins == 10) || shot.number == 2
      @score = @calculator.calculate(shot)
      @total_score += @score
    end
  end
end
