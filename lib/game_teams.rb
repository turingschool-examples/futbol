class GameTeam
  # attr_reader :game_id, 
  #             :team_, 
  #             :type, 
  #             :date_time, 
  #             :away_team_id,
  #             :home_team_id,
  #             :away_goals,
  #             :home_goals,
  #             :venue
  
  def initialize(game_id, 
                team_id, 
                hoa, 
                result, 
                settled_in,
                head_coach,
                goals,
                shots,
                tackles,
                pim,
                powerplayopportunities,
                powerplaygoals,
                faceoffwinpercentage,
                giveaways,
                takeaways)
  
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