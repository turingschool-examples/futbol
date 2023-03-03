require_relative 'stats'

class LeagueStatistics < Stats
  def initialize(locations)
    super
  end

  def count_of_teams
    @teams.count
  end

  # def highest_scoring_visitor
  #   team = @teams.find do |team|
  #     team.team_id == 
  #   end
  # end
end