class Game
  attr_reader :season, :away_goals, :home_goals

  def initialize(season, away_goals, home_goals)
    @season = season
    @away_goals = away_goals
    @home_goals = home_goals
  end
end