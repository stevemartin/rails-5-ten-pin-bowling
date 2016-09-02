  class ScoreBoardPresenter
    def initialize(game)
      @game = game
      @scoreboard = []
    end

    def scoreboard
      @game.players.times { |p| @scoreboard << build_row(p) }
      @scoreboard
    end

    def build_row(player)
      row = row_template
      shots = @game.shots.where(player: player+1).order(:frame, :number)
      if shots.any?
        score_calc = CalculateScore.new(shots)

        totals = []
        shots.each do |shot|
          totals[shot.frame] = row[shot.frame][0] = score_calc.calculate(shot)
          row[shot.frame][shot.number] = shot.pins
        end

        row[11] = totals.compact.reduce(0, :+)
      end
      row
    end

    def total_for_frame(cell)
      cell[0]
    end

    def first_shot(cell)
      cell[1]
    end

    def second_shot(cell)
      cell[2]
    end

    def third_shot(cell)
      cell[3]
    end

    def grand_total(row)
      row[11]
    end

    private
    def row_template
      [
        [], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil, nil], nil
      ]

    end
  end
