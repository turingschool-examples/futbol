require_relative './game_team'
require_relative './game_team_collection'

class GameTeamGame < GameTeamCollection

  def compare_hoa_to_result(hoa, result)
    @game_teams.count do |game|
      game.HoA == hoa && game.result == result
    end.to_f
  end

  def total_amount_games
    @game_teams.count / 2
  end

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_amount_games * 100).round(2)
  end

  def percentage_visitor_wins
    (compare_hoa_to_result("away", "WIN") / total_amount_games * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_amount_games  * 100).round(2)
  end
end
