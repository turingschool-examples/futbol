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

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  end

  def percentage_visitor_wins
    (compare_hoa_to_result("away", "WIN") / total_games * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  end

  def games_in_season(season)
    @game_teams.select do |game|
    @stat_tracker.game_ids_per_season[season].include?(game.game_id)
    end
  end
  #
  #   def games_per_coach(season)
  #     coaches_and_games = {}
  #     games_in_season(season).each do |game|
  #      if coaches_and_games[game["head_coach"]]
  #        coaches_and_games[game["head_coach"]] << game
  #      else coaches_and_games[game["head_coach"]] = [game]
  #      end
  #    end
  #    coaches_and_games
  #   end
  #
  #   def count_coach_results(season)
  #     coaches_and_results = {}
  #     games_per_coach(season).map do |coach, games|
  #         coaches_and_results[coach] = games.count do |game|
  #         game["result"] == "WIN"
  #       end
  #     end
  #     coaches_and_results
  #   end
  #
  #   def coach_percentage(season)
  #     coaches_and_percentages = {}
  #     wins = count_coach_results(season)
  #     wins.keys.map do |coach|
  #       coaches_and_percentages[coach] = (wins[coach].to_f /
  #                                 games_per_coach(season)[coach].count).round(2)
  #     end
  #     coaches_and_percentages
  #   end
  #
  #   def winningest_coach(season)
  #     coach = coach_percentage(season).max_by do |coach, percentage|
  #       percentage
  #     end
  #     coach[0]
  #   end

end
