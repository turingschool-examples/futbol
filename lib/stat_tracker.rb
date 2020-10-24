require 'CSV'
require 'pry'

class StatTracker

    def initialize(locations)
        @games_path = locations[:games]
        @teams_path = locations[:teams]
        @game_teams_path = locations[:game_teams]
    end

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def game_stuff
        # game_data = []
        # CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
        #     game_data << row
        # end
        scores = []
        CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
            game_scores << row[:home_goals].to_i + row[:away_goals].to_i
        end
    end



    def highest_total_score  
        p self.from_cvs(@games_path)
        binding.pry
        # game_scores
        # p scores.max
    end

    def highest_total_score  
    #     game_scores
    #     p scores.max
    end

    def lowest_total_score
    #     game_scores
    #     p scores.max
    end

    def percentage_home_wins
    end

    def league_stuff
    end

    def percentage_home_wins
    end

    def percentage_visitor_wins
    end

    def perentage_ties
    end

    def count_of_game_by_season
    end
    
    def average_goals_per_game
    end
        
    # #     @count_of_teams = 0
    # #     @best_offense = ""
    # #     @worst_offense = ""
    # #     @highest_scoring_visitor = ""
    # #     @highest_scoring_home_team = ""
    # #     @lowest_scoring_visitor = ""
    # #     @lowest_scoring_home_team = ""

    # #     @winningest_coach = ""
    # #     @worst_coach = ""
    # #     @most_accurate_team = ""
    # #     @least_accurate_team = ""
    # #     @most_tackles = ""
    # #     @fewest_tackles = ""

    # #     @team_info = team_data[:team_info]
    # #     @best_season = ""
    # #     @worst_season = ""
    # #     @average_win_percentage = 0.0
    # #     @most_goals_scored = 0
    # #     @fewest_goals_scored = 0
    # #     @favorite_opponent = ""
    # #     @rival = ""
    # # end
end