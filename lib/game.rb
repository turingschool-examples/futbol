class Game
   attr_reader :game_id,
               :season,
               :away_team_id,
               :home_team_id,
               :away_goals,
               :home_goals
   
   def initialize(game_details)
      @game_id = game_details[:game_id].to_i
      @season = game_details[:season].to_i
      @away_team_id = game_details[:away_team_id].to_i
      @home_team_id = game_details[:home_team_id].to_i
      @away_goals = game_details[:away_goals].to_i
      @home_goals = game_details[:home_goals].to_i
   end
end