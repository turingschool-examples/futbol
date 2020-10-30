class Season
    attr_reader :team_id, :season_id, :games_teams

    def initialize(team_id, season_id, games_teams, parent)
        @team_id      = team_id
        @season_id    = season_id
        @games_teams  = games_teams
        @parent       = parent
    end
end