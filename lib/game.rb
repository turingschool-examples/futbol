class Game
  attr_reader :away_goals, :home_goals

  def initialize(game)
    @game_id = game["game_id"].to_i
    @season = game["season"].to_i
    @type = game["type"]
    @date_time = game["date_time"]
    @away_team_id = game["away_team_id"].to_i
    @home_team_id = game["home_team_id"].to_i
    @away_goals = game["away_goals"].to_i
    @home_goals = game["home_goals"].to_i
    @venue = game["venue"]
    @venue_link = game["venue_link"]
  end
end
