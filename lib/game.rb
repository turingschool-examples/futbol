class Game
   attr_reader :game_id,
               :season,
               :away_team_id,
               :home_team_id,
               :away_goals,
               :home_goals
   
   def initialize(game_details)
      @game_id = game_details[:game_id]
      @season = game_details[:season]
      @away_team_id = game_details[:away_team_id]
      @home_team_id = game_details[:home_team_id]
      @away_goals = game_details[:away_goals]
      @home_goals = game_details[:home_goals]
   end
end