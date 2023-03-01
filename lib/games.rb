class Games
  attr_reader :game_id,
              :season_year,
              :season_type,
              :away_team_id,
              :home_team_id,
              :home_goals,
              :away_goals,
              :total_score

  def initialize(details)
    @game_id = details[:game_id]
    @season_year = details[:season]
    @season_type = details[:type]
    @away_team_id = details[:away_team_id]
    @home_team_id = details[:home_team_id]
    @home_goals = details[:home_goals]
    @away_goals = details[:away_goals]
    @total_score = @home_goals + @away_goals
  end
end