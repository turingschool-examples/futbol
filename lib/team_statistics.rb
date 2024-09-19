class TeamStatistic
    attr_reader :teams,
                :stat_tracker
    def initialize(teams,stat_tracker)
        @teams        = teams
        @stat_tracker = stat_tracker
    end

    def team_name(team_id)
        @teams[team_id]&.team_name
    end

    def count_of_teams
        @teams.size
    end
end
attr_reader :game

def initialize(game)
    @game = game
end