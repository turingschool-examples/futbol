require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end

  def games_by_team_id(team_id)
    @game_teams_array.select {|game_team| game_team.team_id.to_i == team_id}
  end

  def total_wins_per_team
    @game_teams_array.select {|game_team| game_team.result == "WIN"}.count
  end

  def total_games_per_team(team_id)
    games_by_team_id(team_id).length
  end

  def average_win_percentage(team_id)
    total_wins_per_team / total_games_per_team(team_id).to_f
  end

  def total_goals_by_team_id(team_id)
    games_by_team_id(team_id).sum {|game_team| game_team.goals.to_i}
  end

  def average_goals_per_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f / games_by_team_id(team_id).count).to_f
  end

  def unique_team_ids
    @game_teams_array.uniq {|game_team| game_team.team_id.to_i}.map { |game_team| game_team.team_id.to_i}
  end

  def best_offense
    unique_team_ids.max_by {|team_id| average_goals_per_team_id(team_id)}
  end

  def worst_offense
    unique_team_ids.min_by {|team_id| average_goals_per_team_id(team_id)}
  end  
end
