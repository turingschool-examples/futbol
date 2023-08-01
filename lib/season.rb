require_relative 'helper_class'

class Season
  attr_reader :season
              :games_played,
              :avg_goals,
              :winningest_coach,
              :worst_coach,
              :most_accurate_team,
              :least_accurate_team,
              :most_tackles,
              :fewest_tackles

  def initialize(season_details)
    @season = season_details[:season]
    @games_played = 0
    @avg_goals = 0
    @winningest_coach = nil
    @worst_coach = nil
    @most_accurate_team = nil
    @least_accurate_team = nil
    @most_tackles = nil
    @fewest_tackles = nil
  end
end