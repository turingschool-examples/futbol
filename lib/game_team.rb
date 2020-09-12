class GameTeam
  def initialize(data, manager)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @home_away = data["HoA"]
    @result = data["result"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"]
    @shots = data["shots"]
    @tackles = data["tackles"]
    @pim = data["pim"]
    @power_opps = data["powerPlayOpportunities"]
    @power_goals = data["powerPlayGoals"]
    @face_off = data["faceOffWinPercentage"]
    @giveaways = data["giveaways"]
    @takeaways = data["takeaways"]
  end
end
