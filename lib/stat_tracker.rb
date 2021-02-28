require 'csv'
require './lib/helper_modules/team_returnable'

class StatTracker
  include ReturnTeamable
  attr_reader :games, :game_teams, :teams
  def initialize
    @games = GameTable.new('./data/games.csv')
    @game_teams = GameTeamTable.new('./data/game_teams.csv')
    @teams = TeamsTable.new('./data/teams.csv')
    require 'pry'; binding.pry
  end
  def send_team_data(teams = '@teams')
    @teams
  end
  def call_test
    @games.other_call(@teams)
  end
  def game_by_season
    @games.game_by_season
  end
  def count_of_teams
    @teams.count_of_teams
  end
  def worst_offense
    return_team(@game_teams.worst_offense, @teams.team_data).teamname
  end
  def highest_scoring_home_team
    return_team(@game_teams.highest_scoring_home_team, @teams.team_data).teamname
  end
  def lowest_scoring_home_team
    return_team(@game_teams.lowest_scoring_home_team, @teams.team_data).teamname
  end
  def team_info(team_id_str)
    @teams.team_info(return_team(team_id_str.to_i, @teams.team_data))
  end
  def worst_season(team_id_str)
    @game_teams.worst_season(return_team(team_id_str.to_i, @teams.team_data).team_id)
  end

end
