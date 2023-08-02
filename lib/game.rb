class Game
  attr_reader :season, :away_goals, :home_goals

  def initialize(game_data)
    @season = game_data[:season]
    @away_goals = game_data[:away_goals].to_i
    @home_goals = game_data[:home_goals].to_i
  end
end