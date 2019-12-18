class Game
  attr_reader :season, :away_goals, :home_goals

  def initialize(game_info)
    @season = game_info[:season]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
  end

  def total_score
    total_score = @away_goals + @home_goals
    total_score
  end

  def difference_between_score
    difference_between_score = @away_goals - @home_goals
    difference_between_score.abs
  end
end
