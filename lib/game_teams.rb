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
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways

   def initialize(game_teams_param)
     @game_id = game_teams_param[:game_id]
     @team_id = game_teams_param[:team_id]
     @hoa = game_teams_param[:hoa]
     @result = game_teams_param[:result]
     @settled_in = game_teams_param[:settled_in]
     @head_coach = game_teams_param[:head_coach]
     @goals = game_teams_param[:goals].to_i
     @shots = game_teams_param[:shots].to_i
     @tackles = game_teams_param[:tackles].to_i
     @pim = game_teams_param[:pim].to_i
     @powerplayopportunities = game_teams_param[:powerplayopportunities].to_i
     @powerplaygoals = game_teams_param[:powerplaygoals].to_i
     @faceoffwinpercentage = game_teams_param[:faceoffwinpercentage].to_f
     @giveaways = game_teams_param[:giveaways].to_i
     @takeaways = game_teams_param[:takeaways].to_i
   end
end
