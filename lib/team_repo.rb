require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_team_repo'

class TeamRepo
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    @game_team_repo.average_goals_team

    @teams.find do |game|
      if game.team_id == avg_goals_by_team.key(avg_goals_by_team.values.max)
          game.teamname
      end
    end
  end
end