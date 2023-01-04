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
                :powerplay_opportunities,
                :powerplay_goals,
                :faceoff_win_percentage,
                :giveaways,
                :takeaways
                
    def initialize(info)
        @game_id = info[:game_id]
        @team_id = info[:team_id]
        @hoa = info[:HoA]
        @result = info[:result]
        @settled_in = info[:settled_in]
        @head_coach = info[:head_coach]
        @goals = info[:goals]
        @shots = info[:shots]
        @tackles = info[:tackles]
        @pim = info[:pim]
        @powerplay_opportunities = info[:powerPlayOpportunities]
        @powerplay_goals = info[:powerPlayGoals]
        @faceoff_win_percentage = info[:faceOffWinPercentage]
        @giveaways = info[:giveaways]
        @takeaways = info[:takeaways]
    end
end