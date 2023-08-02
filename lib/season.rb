require_relative 'helper_class'

class Season
  attr_reader :season,
              :game_count,
              :games_played,
              :avg_goals,
              :winningest_coach,
              :worst_coach,
              :most_accurate_team,
              :least_accurate_team,
              :most_tackles,
              :fewest_tackles

  def initialize(season, game_count, games_played, avg_goals)
    @season = season
    @game_count = game_count
    @games_played = games_played
    @avg_goals = avg_goals
    @winningest_coach = nil
    @worst_coach = nil
    @most_accurate_team = nil
    @least_accurate_team = nil
    @most_tackles = nil
    @fewest_tackles = nil
  end
end