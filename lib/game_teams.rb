class GameTeams

    attr_reader :game_id,
                :team_id,
                :hoa,
                :results,
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
                :takeaways,
                :tracker

    def initialize(data, tracker)
        @game_id = data[:game_id]
        @team_id = data[:team_id]
        @hoa = data[:hoa]
        @results = data[:results]
        @settled_in = data[:settled_in]
        @head_coach = data[:head_coach]
        @goals = data[:goals]
        @shots = data[:shots]
        @tackles = data[:tackles]
        @pim = data[:pim]
        @power_play_opportunities = data[:powerPlayOpportunities]
        @power_play_goals = data[:powerPlayGoals]
        @face_off_win_percentage = data[:faceOffWinPercentage]
        @giveaways = data[:giveaways]
        @takeaways = data[:takeaways]
        @tracker = tracker
    end
end
