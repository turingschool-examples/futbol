class Game
  attr_reader :game_id,
              :season,
              :season_type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals
  def initialize(game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @season_type = game_info[:type]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
  end
  #StatTracker will reference total_goals for highest_total_score and lowest_total_score
  def total_goals
    @away_goals + @home_goals
  end
  # To use in highest_scoring_visitor, highest_scoring_home_team, etc? Or else other class using the game_team file data?
  def home_win?
    @home_goals > @away_goals
  end

  def visitor_win?
    @away_goals > @home_goals
  end

  def tie?
    @home_goals == @away_goals
  end
end