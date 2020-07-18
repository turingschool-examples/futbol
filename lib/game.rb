class Game
  def initialize(data)
    @away_goals = data["away_goals"].to_i
    @home_goals = data["home_goals"].to_i
    
  end

  def total_game_score
    @away_goals + @home_goals
  end
end