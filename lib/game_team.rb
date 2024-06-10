class GameTeam
    attr_reader :game_id, :team_id, :HoA, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways
    

    def initialize(data)
        @game_id = data[:game_id]
        @team_id = data[:team_id]
        @HoA = data[:hoa]
        @result = data[:result]
        @settled_in = data[:settled_in]
        @head_coach = data[:head_coach]
        @goals = data[:goals].to_i
        @shots = data[:shots].to_i
        @tackles = data[:tackles].to_i
        @pim = data[:pim].to_i
        @powerPlayOpportunities = data[:powerplayopportunities].to_i
        @powerPlayGoals = data[:powerplaygoals].to_i
        @faceOffWinPercentage = data[:faceoffwinpercentage].to_f
        @giveaways = data[:giveaways].to_i
        @takeaways = data[:takeaways].to_i
        
    end
end