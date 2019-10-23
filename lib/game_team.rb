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
              :pp_opps,
              :pp_goals,
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
    @pp_opps = game_team_info[:powerplayopportunities]
    @pp_goals = game_team_info[:powerplaygoals]
    @face_off_win_percentage = game_team_info[:faceoffwinpercentage]
    @giveaways = game_team_info[:giveaways]
    @takeaways = game_team_info[:takeaways]
  end
end
