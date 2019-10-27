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
    :power_play_opportunities,
    :power_play_goals,
    :face_off_win_percentage,
    :giveaways,
    :takeaways
    
  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals]
    @shots = game_team_info[:shots]
    @tackles = game_team_info[:tackles]
    @pim = game_team_info[:pim]
    @power_play_opportunities = game_team_info[:power_play_opportunities]
    @power_play_goals = game_team_info[:power_play_goals]
    @face_off_win_percentage = game_team_info[:face_off_win_percentage]
    @giveaways = game_team_info[:giveaways]
    @takeaways = game_team_info[:takeaways]
  end
end
