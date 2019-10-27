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
    @goals = game_team_info[:goals].to_i
    @shots = game_team_info[:shots].to_i
    @tackles = game_team_info[:tackles].to_i
    @pim = game_team_info[:pim].to_i
    @pp_opps = game_team_info[:powerplayopportunities].to_i
    @pp_goals = game_team_info[:powerplaygoals].to_i
    @face_off_win_percentage = game_team_info[:faceoffwinpercentage]
    @giveaways = game_team_info[:giveaways].to_i
    @takeaways = game_team_info[:takeaways].to_i
  end
end
