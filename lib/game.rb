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

  def winner
    return "home" if @home_goals > @away_goals
    return "away" if @away_goals > @home_goals
    return "tie" if @home_goals == @away_goals
  end
end