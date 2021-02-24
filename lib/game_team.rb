class GameTeam
  attr_reader :game_id, :team_id, :home_or_away, :result,
              :settled_in, :head_coach, :goals, :shots, 
              :tackles, :pim, :power_play_opportunities,
              :power_play_goals, :face_off_win_percentage,
              :giveaways, :takeaways

   def initialize(raw_data)
    @raw_data = raw_data
    @game_id = raw_data[:game_id]
    @team_id = raw_data[:team_id]
    @home_or_away = raw_data[:HoA]
    @result = raw_data[:result]
    @settled_in = raw_data[:settled_in]
    @head_coach = raw_data[:head_coach]
    @goals = raw_data[:goals].to_i
    @shots = raw_data[:shots].to_i
    @tackles = raw_data[:tackles].to_i
    @pim = raw_data[:pim].to_i
    @power_play_opportunities = raw_data[:powerPlayOpportunities].to_i
    @power_play_goals = raw_data[:powerPlayGoals].to_i
    @face_off_win_percentage = raw_data[:faceOffWinPercentage].to_f
    @giveaways = raw_data[:giveaways].to_i
    @takeaways = raw_data[:takeaways].to_i
   end
end