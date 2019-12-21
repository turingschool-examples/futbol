class GameTeams
  attr_reader :team_id,
              :HoA,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :giveaways,
              :takeaways

  def initialize(game_id)
    @team_id = game_id[:team_id]
    @hoa = game_id[:HoA]
    @result = game_id[:result]
    @settled_in = game_id[:settled_in]
    @head_coach = game_id[:head_coach]
    @goals = game_id[:goals]
    @shots = game_id[:shots]
    @tackles = game_id[:tackles]
    @giveaways = game_id[:giveaways]
    @takeaways = game_id[:takeaways]
  end
end
