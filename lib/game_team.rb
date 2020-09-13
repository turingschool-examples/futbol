class GameTeam
  attr_reader :game_id,
              :team_id,
              :home_away,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_opps,
              :power_goals,
              :face_off,
              :giveaways,
              :takeaways,
              :manager,
              :season_id

  def initialize(data, manager)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @home_away = data["HoA"]
    @result = data["result"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"].to_i
    @shots = data["shots"].to_i
    @tackles = data["tackles"].to_i
    @pim = data["pim"]
    @power_opps = data["powerPlayOpportunities"]
    @power_goals = data["powerPlayGoals"]
    @face_off = data["faceOffWinPercentage"]
    @giveaways = data["giveaways"]
    @takeaways = data["takeaways"]
    @manager = manager
    @season_id = find_season_id(@game_id)
  end

  def find_season_id(game_id)
    @manager.find_season_id(game_id)
  end

end
