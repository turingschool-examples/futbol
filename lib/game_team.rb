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

  def initialize(game_teams_data)
        @game_id = game_teams_data[:game_id]
        @team_id = game_teams_data[:team_id]
        @hoa = game_teams_data[:hoa]
        @result = game_teams_data[:result]
        @settled_in = game_teams_data[:settled_in]
        @head_coach = game_teams_data[:head_coach]
        @goals = game_teams_data[:goals].to_i
        @shots = game_teams_data[:shots].to_i
        @tackles = game_teams_data[:tackles].to_i
        @pim = game_teams_data[:pim].to_i
        @power_play_opportunities = game_teams_data[:power_play_opportunities].to_i
        @power_play_goals = game_teams_data[:power_play_goals].to_i
        @face_off_win_percentage = game_teams_data[:face_off_win_percentage].to_f
        @giveaways = game_teams_data[:giveaways].to_i
        @takeaways = game_teams_data[:takeaways].to_i          

  end

end