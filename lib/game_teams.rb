class GameTeams

  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :powerplayopportunities, :powerplaygoals,
              :faceoffwinpercentage, :giveaways, :takeaways

  def initialize(stats)
    @game_id = stats[:game_id].to_i
    @team_id = stats[:team_id].to_i
    @hoa = stats[:hoa]
    @result = stats[:result]
    @settled_in = stats[:settled_in]
    @head_coach = stats[:head_coach]
    @goals = stats[:goals].to_i
    @shots = stats[:shots].to_i
    @tackles = stats[:tackles].to_i
    @pim = stats[:pim].to_i
    @powerplayopportunities = stats[:powerplayopportunities].to_i
    @powerplaygoals = stats[:powerplaygoals].to_i
    @faceoffwinpercentage = stats[:faceoffwinpercentage].to_f
    @giveaways = stats[:giveaways].to_i
    @takeaways = stats[:takeaways].to_i
  end



end
