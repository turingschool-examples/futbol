

class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :ppo,
              :ppg,
              :fowp,
              :giveaways,
              :takeaways
              
  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles = data[:tackles]
    @pim = data[:pim]
    @ppo = data[:powerplayopportunities]
    @ppg = data[:powerplaygoals]
    @fowp = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end

end
