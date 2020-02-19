require_relative 'game_teams'
require_relative 'data_loadable'

class GameTeamStats
  include DataLoadable
  attr_reader :game_teams

  def initialize(file_path, object)
    @game_teams = csv_data(file_path, object)
  end

  def unique_team_ids
    @game_teams.uniq {|game_team| game_team.team_id}.map { |game_team| game_team.team_id}
  end

end
