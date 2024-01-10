class GameTeams
    attr_reader :game_id,
                :team_id,
                :hoa,
                :result,
                :settled_in,
                :head_coach,
                :goals,
                :shots,
                :tackles
                :pim,
                :powerPlayOpportunities,
                :powerPlayGoals,
                :faceOffWinPercentage,
                :giveaways,
                :takeaways

    def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, powerPlayOpportunities, powerPlayGoals, faceOffWinPercentage, giveaways, takeaways)
        @game_id = game_id
        @team_id = team_id
        @hoa = hoa
        @result = result
        @settled_in = settled_in
        @head_coach = head_coach
        @goals = goals
        @shots = shots
        @tackles = tackles
        @pim = pim
        @powerPlayOpportunities = powerPlayOpportunities
        @powerPlayGoals = powerPlayGoals
        @faceOffWinPercentage = faceOffWinPercentage
        @giveaways = giveaways
        @takeaways = takeaways
    end

    # will need an array in this method
    def create_game_teams(file_path)
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            game_id =row[:game_id]
            team_id = row[:team_id]
            hoa = row[:hoa]
            result = row[:result]
            settled_in = row[:settled_in]
            head_coach = row[:head_coach]
            goals = row[:goals]
            shots = row[:shots]
            tackles = row[:tackles]
            pim = row[:pim]
            powerPlayOpportunities = row[:powerPlayOpportunities]
            powerPlayGoals = row[:powerPlayGoals]
            faceOffWinPercentage = row[:faceOffWinPercentage]
            giveaways = row[:giveaways]
            takeaways = row[:takeaways]
            game_instance = GameTeams.new(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, powerPlayOpportunities, powerPlayGoals, faceOffWinPercentage, giveaways, takeaways)``
        end
    end
end