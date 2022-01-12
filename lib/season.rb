require_relative './findable.rb'

class Season
  include Findable
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def winningest_coach(season)
    win_percentage_by_coach(season).key(win_percentage_by_coach(season).values.max)
  end

  def worst_coach(season)
    win_percentage_by_coach(season).key(win_percentage_by_coach(season).values.min)
  end

  def win_percentage_by_coach(season)
    wins = games_in_season_by_header(season, :head_coach).transform_values do |values|
      values.reject do |game|
        game if game[:result] != "WIN"
      end
    end
    win_percentage_by_coach = wins.transform_values do |win_games|
      win_games.count.to_f / games_in_season(season).count.to_f
    end
  end

  # def games_in_season(season)
  #   season_games = @games.select do |game|
  #     game[:season] == season
  #   end
  #   game_ids = season_games.map do |game|
  #     game[:game_id]
  #   end
  #   games = @game_teams.select do |game|
  #     game_ids.include?(game[:game_id])
  #   end
  #
  # end

  # def games_in_season_by_header(season, header)
  #   games_in_season(season).group_by {|game| game[header]}
  # end

  def most_accurate_team(season)
    shot_accuracy_hash = Hash.new(0.0)
    total_shots_per_season(season).each_key do |key|
      shot_accuracy_hash[key] = total_goals_per_season(season)[key] / total_shots_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == shot_accuracy_hash.key(shot_accuracy_hash.values.max)
    end
    team_info[:teamname]
  end

  def least_accurate_team(season)
    shot_accuracy_hash = Hash.new(0.0)
    total_shots_per_season(season).each_key do |key|
      shot_accuracy_hash[key] = total_goals_per_season(season)[key] / total_shots_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == shot_accuracy_hash.key(shot_accuracy_hash.values.min)
    end
    team_info[:teamname]
  end

  def total_goals_per_season(season)
    goals_per_team = Hash.new(0)
    games_in_season_by_header(season, :team_id).each do |team_id, game_array|
      goals_per_team[team_id] = game_array.map {|game| game[:goals].to_f}
    end
    goals_per_team.each do |team_id, goals_array|
      goals_per_team[team_id] = goals_array.sum
    end
    goals_per_team
  end

  def total_shots_per_season(season)
    shots_per_team = Hash.new(0)
    games_in_season_by_header(season, :team_id).each do |team_id, game_array|
      shots_per_team[team_id] = game_array.map {|game| game[:shots].to_f}
    end
    shots_per_team.each do |team_id, shots_array|
      shots_per_team[team_id] = shots_array.sum
    end
    shots_per_team
  end

  def most_tackles(season)
    tackles_hash = Hash.new(0.0)
    tackles_per_season(season).each_key do |key|
      tackles_hash[key] = tackles_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == tackles_hash.key(tackles_hash.values.max)
    end
    team_info[:teamname]
  end

  def fewest_tackles(season)
    tackles_hash = Hash.new(0.0)
    tackles_per_season(season).each_key do |key|
      tackles_hash[key] = tackles_per_season(season)[key]
    end
    team_info = @teams.find do |team|
      team[:team_id] == tackles_hash.key(tackles_hash.values.min)
    end
    team_info[:teamname]
  end

  def tackles_per_season(season)
    tackles_per_team = Hash.new(0)
    games_in_season_by_header(season, :team_id).each do |team_id, game_array|
      tackles_per_team[team_id] = game_array.map {|game| game[:tackles].to_f}
    end
    tackles_per_team.each do |team_id, tackles_array|
      tackles_per_team[team_id] = tackles_array.sum
    end
    tackles_per_team
  end
end
