require './lib/parsable.rb'
class StatTracker
  include Parsable

    def initialize(location)
      @game_statistics = GameStatistics.new(location)
      @league_statistics = LeagueStatistics.new(location)
      @season_statistics = SeasonStatistics.new(location)
      @team_statistics = TeamStatistics.new(location)
    end

    def highest_total_score
      #game_statistic
    end

    def lowest_total_score
      #game_statistic
    end

    def percentage_home_wins
      #game_statistic
    end

    def percentage_visitor_wins
      #game_statistic
    end

    def percentage_ties
      #game_statistic
    end

    def count_of_games_by_season
      #game_statistic
    end

    def average_goals_per_game
      #game_statistic
    end

    def average_goals_by_season
      #game_statistic
    end

    def count_of_teams
      #league_statistics
    end

    def best_offense
      #league_statistics
    end

    def worst_offense
      #league_statistics
    end

    def highest_scoring_visitor
      #league_statistics
    end

    def highest_scoring_home_team
      #league_statistics
    end

    def lowest_scoring_visitor
      #league_statistics
    end

    def lowest_scoring_home_team
      #league_statistics
    end

    def winningest_coach
      #season_statistics
    end

    def worst_coach
      #season_statistics
    end

    def most_accurrate_team
      #season_statistics
    end

    def least_accurate_team
      #season_statistics
    end

    def most_tackles
      #season_statistics
    end

    def fewest_tackles
      #season_statistics
    end

    def team_info
      #team_statistics
    end

    def best_season
      #team_statistics
    end

    def worst_season
      #team_statistics
    end

    def average_win_percentage
      #team_statistics
    end

    def most_goals_scored
      #team_statistics
    end

    def fewest_goals_scored
      #team_statistics
    end

    def favorite_opponent
      #team_statistics
    end

    def rival
      #team_statistics
    end

end
