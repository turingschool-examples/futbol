require_relative 'futbol'
class SeasonStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def winningest_coach(season)
    num_coach_wins = Hash.new(0)
    @games.map do |game|
      if game.home_result == "WIN" && game.season == season
        num_coach_wins[game.home_head_coach] += 1
      elsif
        game.away_result == "WIN" && game.season == season
        num_coach_wins[game.away_head_coach] += 1
      end
    end
    num_coach_wins.max_by do |coach, wins|
      wins
    end.first
      # require 'pry'; binding.pry
  end
end