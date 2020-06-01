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

  def to_hash
    {game_id: @game_id, face_off_win_percentage: @face_off_win_percentage,
     give_aways: @give_aways, goals: @goals, head_coach: @head_coach, hoa: @hoa,
    pim: @pim, power_play_goals: @power_play_goals, power_play_opportunities:
    @power_play_opportunities, result: @result, settled_in: @settled_in, shots:
    @shots, tackles: @tackles, take_aways: @take_aways, team_id: @team_id}
  end

end
