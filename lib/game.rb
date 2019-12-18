class Game
  attr_reader :season, :away_goals, :home_goals

  def initialize(game_info)
    @season = game_info[:season]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
  end
end
