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

  def games_per_coach(season)
    coaches_and_games = {}
    games_in_season(season).each do |game|
     (coaches_and_games[game.head_coach] << game if coaches_and_games[game.head_coach]) ||
     (coaches_and_games[game.head_coach] = [game])
     end
    coaches_and_games
  end

  def count_coach_results(season)
    coaches_and_results = {}
    games_per_coach(season).each do |coach, games|
        coaches_and_results[coach] = games.count do |game|
        game.result == "WIN"
      end
    end
    coaches_and_results
  end

  def coach_percentage(season)
    coaches_and_percentages = {}
    wins ||= count_coach_results(season)
    wins.keys.map do |coach|
        coaches_and_percentages[coach] = (wins[coach].to_f /
                                          games_per_coach(season)[coach].count).round(2)
    end
    coaches_and_percentages
  end

  def winningest_coach(season)
    coach = coach_percentage(season).max_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def worst_coach(season)
    coach = coach_percentage(season).min_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def team_scores(season, attribute)
    scores = {}
    games_in_season(season).each do |game|
      if attribute == "shots"
        (scores[game.team_id] += game.shots.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.shots.to_i)
      elsif attribute == "goals"
        (scores[game.team_id] += game.goals.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.goals.to_i)
      end
    end
    scores
  end

  def team_ratios(season)
    goals = team_scores(season, "goals")
    shots = team_scores(season, "shots")
    score_ratios = {}
    ratios = count_coach_results(season)
    goals.keys.map do |team_id|
      score_ratios[team_id] = (goals[team_id].to_f /
                              shots[team_id]).round(2)
    end
    score_ratios
  end

  def most_accurate_team(season)
     team_id = team_ratios(season).max_by do |team, ratio|
      ratio
    end
    #something here
  end
#
#   def least_accurate_team(season)
#     team_id = team_ratios(season).min_by do |team, ratio|
#      ratio
#    end
#    row = @teams_table.find do |row|
#      row["team_id"] == team_id[0]
#    end
#    row["teamName"]
#   end
#
#   def total_tackles(season)
#     teams_tackles = {}
#     games_in_season(season).each do |game|
#       if teams_tackles[game["team_id"]]
#       teams_tackles[game["team_id"]] += game["tackles"].to_i
#       else teams_tackles[game["team_id"]] = game["tackles"].to_i
#       end
#     end
#     teams_tackles
#   end
#
#   def most_tackles(season)
#     team_id = total_tackles(season).max_by do |team, tackles|
#      tackles
#    end
#     row = @teams_table.find do |row|
#      row["team_id"] == team_id[0]
#    end
#    row["teamName"]
#   end
#
#   def least_tackles(season)
#     team_id = total_tackles(season).min_by do |team, tackles|
#      tackles
#     end
#     row = @teams_table.find do |row|
#      row["team_id"] == team_id[0]
#     end
#     row["teamName"]
#   end

end
