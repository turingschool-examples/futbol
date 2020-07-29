#require_relative "./stat_tracker"
require "./lib/stat_tracker"

class SeasonStatistics

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def scoped_season_games(season)
    @games.find_all {|game| game.season == season}
  end

  def games_teams_by_seasons_per_coach(season_id)
    scoped_season_games(season_id).map do |game|
      @game_teams.find_all do |game_team|
        game_team.game_id == game.game_id
      end
    end.flatten.group_by(&:head_coach)
  end

  def coach_name_and_results(season)
    output = {}
    games_teams_by_seasons_per_coach(season).map do |coach, game_teams|
      game_teams.map do |game_team|
        output[coach] ? output[coach] += [game_team.result] : output[coach] = [game_team.result]
      end
    end
    output
  end

  def winningest_coach(season)
    coach_name_and_results(season).max_by do |coach, results|
      win_count = results.find_all { |result| result == "WIN"}.size
      result_sum =  results.size
      (win_count * 100) / result_sum
    end.first
  end

  def worst_coach(season)
    coach_name_and_results(season).min_by do |coach, results|
      win_count = results.find_all { |result| result == "WIN"}.size
      result_sum =  results.size
      (win_count * 100) / result_sum
    end.first
  end

  def team_accuracy(seasonID)
    team_accuracy = Hash.new(0)
    games_per_season_per_team(seasonID).each do |team, games|
      shots = 0
      goals = 0
      games.each do |game|
        shots = games.sum {|game| game.shots}
        goals = games.sum {|game| game.goals}
      end
    team_accuracy[team] = (goals.to_f / shots)
    end
    team_accuracy
  end

  def games_per_season_per_team(seasonID)
    games_in_season = @games.select { |game| game.season == seasonID }
    game_ids_in_season = games_in_season.map do |game|
      game.game_id
    end
    game_teams_in_season = @game_teams.select do |game_team|
      game_ids_in_season.include?(game_team.game_id)
    end
    games_per_season_per_team = game_teams_in_season.group_by do |game|
      game.team_id
    end
  end

  def most_accurate_team(seasonID)
    games_per_season_per_team(seasonID)
    team_accuracy(seasonID)
    best_team = team_accuracy(seasonID).max_by {|team_id, accuracy| accuracy}
    @teams.find {|team| team.team_id == best_team[0]}.teamname
  end

  def least_accurate_team(seasonID)
    games_per_season_per_team(seasonID)
    team_accuracy(seasonID)
    worst_team = team_accuracy(seasonID).min_by {|team_id, accuracy| accuracy}
    @teams.find {|team| team.team_id == worst_team[0]}.teamname
  end

  def team_tackles(seasonID)
    team_tackles = Hash.new(0)
    games_per_season_per_team(seasonID).each do |team, games|
      games.each do |game|
        team_tackles[game.team_id] += game.tackles
      end
    end
    team_tackles
  end

  def fewest_tackles(seasonID)
    games_per_season_per_team(seasonID)
    team_tackles(seasonID)
    fewest = team_tackles(seasonID).min_by {|k, v| v}
    @teams.find {|team| team.team_id == fewest.first}.teamname
  end

  def most_tackles(seasonID)
    games_per_season_per_team(seasonID)
    team_tackles(seasonID)
    most = team_tackles(seasonID).max_by {|k, v| v}
    @teams.find {|team| team.team_id == most.first}.teamname
  end
end
