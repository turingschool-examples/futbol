require 'csv'

class GameStats
  def self.from_csv(locations)
    GameStats.new(locations)
  end

  def initialize(locations)
    @locations = locations #this is a hash
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
    @games_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
  end

  def sum_of_scores
    @games_table.map do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
  end

  def highest_total_score
    sum_of_scores.max
  end

  def lowest_total_score
    sum_of_scores.min
  end

  def compare_hoa_to_result(hoa, result)
    @games_teams_table.to_a.count do |game|
      game[2] == hoa && game[3] == result
    end.to_f
  end

  def total_games
    @games_teams_table.count / 2
  end

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  end

  def percentage_away_wins
    (compare_hoa_to_result("away", "WIN") / total_games  * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  end

end
