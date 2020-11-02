class Game
  attr_reader :home_goals,
              :away_goals,
              :season,
              :type,
              :away_team_id,
              :home_team_id
  def initialize(row)
    @season = row["season"]
    @away_team_id = row["away_team_id"].to_i
    @home_team_id = row["home_team_id"].to_i
    @away_goals = row["away_goals"].to_i
    @home_goals = row["home_goals"].to_i
  end

end
