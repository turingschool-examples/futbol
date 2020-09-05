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
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways
  def initialize(data)
    @game_id = data[:game_id].to_i
    @team_id = data[:team_id].to_i
    @hoa = data[:hoa].to_s
    @result = data[:result].to_s
    @settled_in = data[:settled_in].to_s
    @head_coach = data[:head_coach].to_s
    @goals = data[:goals].to_i
    @shots = data[:shots].to_i
    @tackles = data[:venue].to_i
    @pim = data[:pim].to_i
    @powerPlayOpportunities = data[:powerPlayOpportunities].to_i
    @powerPlayGoals = data[:powerPlayGoals].to_i
    @faceOffWinPercentage = data[:faceOffWinPercentage].to_i
    @giveaways = data[:giveaways].to_i
    @takeaways = data[:takeaways].to_i
  end

end
