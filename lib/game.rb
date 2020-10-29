class Game
  attr_reader :id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals
  def initialize(data)
    @id = data[:game_id].to_i
    @season = data[:season]
    @away_team_id = data[:away_team_id].to_i
    @home_team_id = data[:home_team_id].to_i
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
  end

  def home_win?
    @home_goals > @away_goals
  end

  def visitor_win?
    @away_goals > @home_goals
  end

  def tie?
    @away_goals == @home_goals
  end

  def total_score
    @home_goals + @away_goals
  end
end
