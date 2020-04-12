require 'csv'
require_relative 'collection'

class TeamStats < Collection
  attr_reader :team_stats

  def initialize(file_path)
    @team_stats = create_objects(file_path, GameStats)
  end

  def all_games_for(team_id)
    games_played = @team_stats.find_all do |team_stat|
      team_stat.team_id == team_id
    end
    games_played
  end

  def most_goals_scored(team_id)
    all_games_for(team_id).max_by {|team_stat| team_stat.goals}.goals
  end

  def fewest_goals_scored(team_id)
    all_games_for(team_id).min_by {|team_stat| team_stat.goals}.goals
  end

  def average_win_percentage(team_id)
    total_games = all_games_for(team_id)
    games_won = total_games.find_all {|game|game.result == "WIN"}
    average_percentage = (games_won.length.to_f/total_games.length)
    average_percentage.round(2)
  end
end
