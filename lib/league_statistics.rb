require_relative 'stats'

class LeagueStatistics < Stats
  def initialize(locations)
    super
  end

  def count_of_teams
    @teams.count
  end

  # def best_offense
  # end

  # def worst_offense
  # end

  # def highest_scoring_visitor
  #   team = @teams.find do |team|
  #     team.team_id == 
  #   end
  # end

  # def highest_scoring_home_team
  # end

  # def lowest_scoring_visitor
  # end

  # def lowest_scoring_home_team
  # end
end