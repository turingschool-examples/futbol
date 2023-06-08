class GameTeam
attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways

  def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, powerplayopportunities, powerplaygoals, faceoffwinpercentage, giveaways, takeaways) 
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa 
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @power_play_opportunities = powerplayopportunities
    @power_play_goals = powerplaygoals
    @face_off_win_percentage = faceoffwinpercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end
end