require_relative 'test_helper'

class TeamStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path, game_teams: game_teams_path})
    @team_stat_helper ||= TeamStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table, @stat_tracker.game_team_table)
  end

  

end
