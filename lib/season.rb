class Season
    attr_reader :team_id, :season_id, :game_teams

    def initialize(team_id, season_id, game_teams, parent)
        @team_id      = team_id
        @season_id    = season_id
        @game_teams   = game_teams
        @parent       = parent
    end
end
