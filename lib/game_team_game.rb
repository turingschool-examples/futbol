require_relative './game_team'
require_relative './game_team_collection'
require_relative "./divisable"

class GameTeamGame < GameTeamCollection
  include Divisable
  def compare_hoa_to_result(hoa, result)
    @game_teams.count do |game|
      game.HoA == hoa && game.result == result
    end.to_f
  end

  def total_amount_games
    @game_teams.count / 2
  end

  def percentage_home_wins
    percentage(compare_hoa_to_result("home", "WIN"), total_amount_games)
  end

  def percentage_visitor_wins
    percentage(compare_hoa_to_result("away", "WIN"), total_amount_games)
  end

  def percentage_ties
    percentage(compare_hoa_to_result("away", "TIE"), total_amount_games)
  end
end
