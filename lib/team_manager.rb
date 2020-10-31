require 'csv'

class TeamManager
  attr_reader :teams
  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    teams_data = CSV.read(file_location, headers: true)
    @teams = teams_data.map do |team_data|
      Team.new(team_data)
    end
  end

  def team_name(id)
    @teams.find do |team|
      team.team_id == id
    end.team_name
  end

  def team_info(id)
    @teams.find do |team|
      team.team_id == id
    end.team_info
  end

  def count_of_teams
    @teams.size
  end

  def best_season(id)
    #sort games by team id (find_all that match team id) .include for home or away ids => collection that we will iterate over to breakout into seasons; games by season with team id; if game.home_team == arg || game.away_team == arg; games_by_team_id
    #find win percentage for each season use an if home_id == team_id, make helper methods in game_teams; helper method for winningest coach sorts wins by season
    # game manager
  end
end
