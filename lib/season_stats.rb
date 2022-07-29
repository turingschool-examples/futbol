class SeasonStats
    attr_reader :game,
                :teams,
                :game_teams
    def inititalize(game, teams, game_teams)
        @game = game
        @teams = teams
        @game_teams = game_teams
    end
end
