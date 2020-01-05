class GameTeams
  attr_reader :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :giveaways,
              :takeaways

  def initialize(row)
    @team_id = row[:team_id]
    @hoa = row[:hoa]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals]
    @shots = row[:shots]
    @tackles = row[:tackles]
    @giveaways = row[:giveaways]
    @takeaways = row[:takeaways]
  end
end
