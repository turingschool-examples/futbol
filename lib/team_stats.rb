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
end
