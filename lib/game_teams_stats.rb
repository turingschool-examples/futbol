require_relative './lib/data_module'

class GameTeamsStats
  include DataLoadable

  def initialize(game_teams_path_param)
    @game_teams_path = game_teams_path_param
  end

  def percentage_home_wins
    game_teams = csv_data(@game_teams_path)

    home_wins = game_teams.count do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end

    home_games = game_teams.count do |game|
      game[:hoa] == "home"
    end

    (100 * home_wins.fdiv(home_games)).round(2)
  end

end
