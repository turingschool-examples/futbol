require_relative 'game_teams'
require_relative 'data_loadable'

class GameTeamStats
  include DataLoadable
  attr_reader :game_teams

  def initialize(file_path, object)
    @game_teams = csv_data(file_path, object)
  end

  def unique_team_ids
    @game_teams.uniq { |game_team| game_team.team_id}.map { |game_team| game_team.team_id }
  end

  def games_by_team(team_id)
    @game_teams.find_all { |team| team.team_id == team_id }
  end

  def total_games_by_team_id(team_id)
    games_by_team(team_id).length
  end

  def total_goals_by_team_id(team_id)
      games_by_team(team_id).sum {|game_team| game_team.goals}
  end

  def average_goals_per_team(team_id)
    total_goals_by_team_id(team_id) / total_games_by_team_id(team_id)
  end
end
