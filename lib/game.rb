class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game_data)
    @game_id = game_data["game_id"]
    @season = game_data["season"]
    @away_team_id = game_data["away_team_id"]
    @home_team_id = game_data["home_team_id"]
    @away_goals = game_data["away_goals"].to_i
    @home_goals = game_data["home_goals"].to_i
  end

  def home_win?
    @home_goals > @away_goals
  end

  def away_win?
    @away_goals > @home_goals
  end

  def has_team?(team_id)
    @home_team_id == team_id || @away_team_id == team_id
  end

  def home_team?(team_id)
    @home_team_id == team_id
  end

  def winner?(team_id)
    home_team?(team_id) && home_win? || !home_team?(team_id) && away_win?
  end
end
