class Season
  attr_reader :games_by_season
  def initialize(games_by_season)
    @games_by_season = games_by_season
  end
end