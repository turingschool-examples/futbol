class GameTeams
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :power_play_opportunities,
              :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways
    def initialize(info)
    @game_id = info[:game_id].to_i
    @team_id = info[:team_id].to_i
    @hoa = info[:HoA]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @tackles = info[:tackles]
    @pim = info[:pim].to_i
    @power_play_opportunities = [:powerPlayOpportunities].to_i
    @power_play_goals = [:powerPlayGoals].to_i
    @face_off_win_percentage = [:faceOffWinPercentage].to_i
    @giveaways = [:giveaways].to_i
    @takeaways = [:takeaways].to_i
end
