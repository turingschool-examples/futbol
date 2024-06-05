require 'csv'

class Game_teams
    attr_reader :game_id,
                :team_id,
                :HoA,
                :result,
                :settled_in,
                :head_coach,
                :goals,
                :shots,
                :tackles,
                :pim,
                :powerPlayOpportunities,
                :powerPlayGoals,
                :faceOffWinPercentage,
                :giveaways,
                :takeaways

    def initialize(game_teams_data)
        @game_id = game_teams_data[:game_id]
        @team_id = game_teams_data[:team_id]
        @HoA = game_teams_data[:HoA]
        @result = game_teams_data[:result]
        @settled_in = game_teams_data[:settled_in]
        @head_coach = game_teams_data[:head_coach]
        @goals = game_teams_data[:goals]
        @shots = game_teams_data[:shots]
        @tackles = game_teams_data[:tackles]
        @pim = game_teams_data[:pim]
        @powerPlayOpportunities = game_teams_data[:powerPlayOpportunities]
        @powerPlayGoals = game_teams_data[:powerPlayGoals]
        @faceOffWinPercentage = game_teams_data[:faceOffWinPercentage]
        @giveaways = game_teams_data[:giveaways]
        @takeaways = game_teams_data[:takeaways]       
        
    end


end


