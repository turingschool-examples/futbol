require "csv"
require './lib/game_team'

class GameTeamCollection
  attr_reader :game_team_path, :stat_tracker

  def initialize(game_team_path, stat_tracker)
    @game_team_path = game_team_path
    @stat_tracker   = stat_tracker
    @game_teams     = []
    create_game_teams(game_team_path)
  end

  def create_game_teams(game_team_path)
    data = CSV.parse(File.read(game_team_path), headers: true)
    @game_teams = data.map {|data| GameTeam.new(data, self)}
  end

  #FROM THE GAMES STATS SECTION
  def compare_hoa_to_result(hoa, result)
    @game_teams.count do |game|
      game.HoA == hoa && game.result == result
    end.to_f
  end

  def total_games
    @game_teams.count / 2
  end

  # def percentage_home_wins
  #   (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  # end
  #
  # def percentage_visitor_wins
  #   (compare_hoa_to_result("away", "WIN") / total_games  * 100).round(2)
  # end
  #
  # def percentage_ties
  #   (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  # end
end
