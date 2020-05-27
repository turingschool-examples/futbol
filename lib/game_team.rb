class GameTeam

  attr_reader :game_id, :team_id, :HoA, :result, :settled_in,
              :head_coach, :goals, :shots, :tackles, :pim,
              :powerPlayOpportunities, :powerPlayGoals,
              :faceOffWinPercentage, :giveaways, :takeaways

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
    @power_play_opportunities = data[:powerplayopportunities]
    @power_play_goals = data[:powerplaygoals]
    @face_off_win_percentage = data[:faceoffwinpercentage]
    @give_aways = data[:giveaways]
    @take_aways = data[:takeaways]
  end

end
