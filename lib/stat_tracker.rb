
require "csv"
require_relative "./game_collection"
require_relative "./team_collection"
require_relative "./game_team_collection"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @g ||= @games.all
  end

  def teams
    @t ||= @teams.all
  end

  def game_teams
    @g_t ||= @game_teams.all
  end
  ###################
  ## SEASON METHODS##
  ###################

  def all_games_per_season(season_id)
    games.select do |game|
      game.season.eql?(season_id)
    end
  end

  def all_game_teams_per_season(season_id)
    game_ids_per_season = all_games_per_season(season_id).group_by {|game| game.game_id}.keys
    game_teams.select do |game_team|
      game_ids_per_season.include?(game_team.game_id)
    end
  end

  def games_by_head_coach(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
  end

  def coach_per_total_win(season_id)
    games_by_head_coach(season_id).transform_values do |games|
      winning_games = games.select{|game| game.result == "WIN"}
      winning_games.size
    end
  end

  def winningest_coach(season_id)
    highest_coach = coach_per_total_win(season_id).max_by do |coach, total_winning_games|
      total_winning_games
    end
    highest_coach.first
  end

  def worst_coach(season_id)
    lowest_coach = coach_per_total_win(season_id).min_by do |coach, total_winning_games|
      total_winning_games
    end
    lowest_coach.first
  end

  def team_id_group(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def ratio_of_shots(season_id)
    team_id_group(season_id).transform_values do |games|
      total_shots = games.sum{|game| game.shots.to_f}
      total_goals = games.sum{|game| game.goals.to_f}
       (total_goals/total_shots *100).round(2)
    end
  end

  def best_accurate_team_id(season_id)
    max = ratio_of_shots(season_id).max_by{|team_id, ratio| ratio}
    max.first
  end

  def least_accurate_team_id(season_id)
    min = ratio_of_shots(season_id).min_by{|team_id, ratio| ratio}
    min.first
  end

  def find_team_by_id(team_id)
    teams.find {|team| team.team_id == team_id}
  end

  def most_accurate_team(season_id)
    team_f = find_team_by_id(best_accurate_team_id(season_id))
    team_f.team_name
  end

  def least_accurate_team(season_id)
    team_f = find_team_by_id(least_accurate_team_id(season_id))
    team_f.team_name
  end

  def total_tackles_team_per_season(season_id)
    team_id_group(season_id).transform_values do |games|
      games.sum{|game| game.tackles.to_i}
    end
  end

  def get_team_name_with_id(id)
    team_f = find_team_by_id(id)
    team_f.team_name
  end

  def most_tackles(season_id)
    max_id = total_tackles_team_per_season(season_id).max_by do |key, value|
       value
    end.first
    get_team_name_with_id(max_id)
  end

  def fewest_tackles(season_id)
    min_id = total_tackles_team_per_season(season_id).min_by do |key, value|
       value
    end.first
    get_team_name_with_id(min_id)
  end
end
