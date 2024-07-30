class Season

    attr_reader :game_id,
                :team_id, 
                :hoa, 
                :result,
                :settle_in,
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

    def initialize(data)
        @game_id = data[:game_id].to_i
        @team_id = data[:team_id].to_i
        @hoa = data[:hoa]
        @result = data[:result]
        @settle_in = data[:settle_in]
        @head_coach = data[:head_coach]
        @goals = data[:goals].to_i
        @shots = data[:shots].to_i
        @tackles = data[:tackles].to_i
        @pim = data[:pim].to_i
        @powerplayopportunities = data[:powerplayopportunities].to_i
        @powerplaygoals = data[:powerplaygoals].to_i
        @faceoffwinpercentage = data[:faceoffwinpercentage].to_i
        @giveaways = data[:giveaways].to_i
        @takeaways = data[:takeaways].to_i

    end
end
