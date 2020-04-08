class GameStats
  attr_reader :game_id, :team_id, :home_away, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :power_play_opportunities,
              :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways

  def initialize(game_stats)
    @game_id = game_stats[:game_id].to_i
    @team_id = game_stats[:team_id].to_i
    @home_away = game_stats[:hoa]
    @result = game_stats[:result]
    @settled_in = game_stats[:settled_in]
    @head_coach = game_stats[:head_coach]
    @goals = game_stats[:goals].to_i
    @shots = game_stats[:shots].to_i
    @tackles = game_stats[:tackles].to_i
    @pim = game_stats[:pim].to_i
    @power_play_opportunities = game_stats[:powerplayopportunities].to_i
    @power_play_goals = game_stats[:powerplaygoals].to_i
    @face_off_win_percentage = game_stats[:faceoffwinpercentage].to_f
    @giveaways = game_stats[:giveaways].to_i
    @takeaways = game_stats[:takeaways].to_i
  end
end
