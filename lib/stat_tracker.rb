class StatTracker

    def initialize (game_data, game_avg, team_data)
        @highest_total_score = 0
        @lowest_total_score = 0
        @percentage_home_wins = 0.0
        @percentage_visitor_wins = 0.0
        @perentage_ties = 0.0
        @count_of_game_by_season = game_count[:count_of_game_by_season]
        @average_goals_per_game = 0.0
        @average_goals_by_season = game_avg[:average_goals_by_season]
        
        @count_of_teams = 0
        @best_offense = ""
        @worst_offense = ""
        @highest_scoring_visitor = ""
        @highest_scoring_home_team = ""
        @lowest_scoring_visitor = ""
        @lowest_scoring_home_team = ""

        @winningest_coach = ""
        @worst_coach = ""
        @most_accurate_team = ""
        @least_accurate_team = ""
        @most_tackles = ""
        @fewest_tackles = ""

        @team_info = team_data[:team_info]
        @best_season = ""
        @worst_season = ""
        @average_win_percentage = 0.0
        @most_goals_scored = 0
        @fewest_goals_scored = 0
        @favorite_opponent = ""
        @rival = ""
    end
end