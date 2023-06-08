module GoalsUtility

    def sums_of_home_away_goals
        @sums_of_home_away_goals ||= games.map { |game| (game.away_goals + game.home_goals)}
    end
end