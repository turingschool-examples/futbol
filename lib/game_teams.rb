class GameTeams
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

  def initialize(game_teams_info)
    @game_id = game_teams_info[:game_id]
    @team_id = game_teams_info[:team_id]
    @hoa = game_teams_info[:hoa]
    @result = game_teams_info[:result]
    @settled_in = game_teams_info[:settled_in]
    @head_coach = game_teams_info[:head_coach]
    @goals = game_teams_info[:goals]
    @shots = game_teams_info[:shots]
    @tackles = game_teams_info[:tackles]
    @pim = game_teams_info[:pim]
    @power_play_opportunities = game_teams_info[:powerplayopportunities]
    @power_play_goals = game_teams_info[:powerplaygoals]
    @face_off_win_percentage = game_teams_info[:faceoffwinpercentage]
    @giveaways = game_teams_info[:giveaways]
    @takeaways = game_teams_info[:takeaways]
  end
end
