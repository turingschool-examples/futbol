class GameTeam
  def initialize(game_team)
    @game_id = game_team["game_id"].to_i
    @team_id = game_team["team_id"].to_i
    @hoa = game_team["HoA"]
    @result = game_team["result"]
    @settled_in = game_team["settled_in"]
    @head_coach = game_team["head_coach"]
    @goals = game_team["goals"].to_i
    @shots = game_team["shots"].to_i
    @tackles = game_team["tackles"].to_i
    @pim = game_team["pim"].to_i
    @power_play_opportunities = game_team["powerPlayOpportunities"].to_i
    @power_play_goals = game_team["powerPlayGoals"].to_i
    @face_off_win_percentage = game_team["faceOffWinPercentage"].to_f
    @giveaways = game_team["giveaways"].to_i
    @takeaways = game_team["takeaways"].to_i 
  end
end
