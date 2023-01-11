require "csv"
# require_relative "array_generator"
require_relative "game"
require_relative "team"
require_relative "game_team"
require_relative "game_repo"
require_relative "team_repo"
require_relative "game_team_repo"


class StatTracker
    # include ArrayGenerator

    attr_reader :games,
                :teams,
                :game_teams

    def initialize(locations)
        @games = GameRepo.new(locations)
        @teams = TeamRepo.new(locations)
        @game_teams = GameTeamRepo.new(locations)
    end

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def highest_total_score
       @games.highest_total_score
    end

    def lowest_total_score
        @games.lowest_total_score
    end
    
    def percentage_home_wins
       @games.percentage_home_wins
    end

    def percentage_visitor_wins
        @games.percentage_visitor_wins
    end

    def percentage_ties
        @games.percentage_ties
    end

    def count_of_games_by_season
        @games.count_of_games_by_season
    end

    def average_goals_per_game
        @games.average_goals_per_game                   
    end

    def average_goals_by_season
        @games.average_goals_by_season
    end
    
    def count_of_teams
        @teams.count_of_teams
    end

    def best_offense
        @game_teams.best_offense
    end

    def worst_offense
        @teams.get_team_name(@game_teams.lowest_avg_goals_by_team)
    end

    def highest_scoring_visitor
       @game_teams.highest_scoring_visitor
    end

    def highest_scoring_home_team
        @game_teams.highest_scoring_home_team
    end

    def lowest_scoring_visitor
        @game_teams.lowest_scoring_visitor
    end

    def lowest_scoring_home_team
        @game_teams.lowest_scoring_home_team
    end

    def winningest_coach(season_id)
        @game_teams.winningest_coach(season_id)
    end

    def worst_coach(season_id)
        @game_teams.worst_coach(season_id)
    end

    def most_accurate_team(season)
      @game_teams.most_accurate_team(season)
    end

    def least_accurate_team(season)
       @game_teams.least_accurate_team(season)
    end

    def most_tackles(season_id)
        @game_teams.most_tackles(season_id)
    end

    def fewest_tackles(season_id)
       @game_teams.fewest_tackles(season_id)
    end

    def most_goals_scored(team_id)
        @game_teams.most_goals_scored(team_id)
    end

    def fewest_goals_scored(team_id)
        @game_teams.fewest_goals_scored(team_id)
    end

    def team_info(team_id)
        @teams.team_info(team_id)
    end

    def best_season(team_id)
        @games.best_season(team_id)
    end

    def worst_season(team_id)
        @games.worst_season(team_id)
    end

    def average_win_percentage(team_id)
        @game_teams.average_win_percentage(team_id)
    end
    
    def favorite_opponent(team_id)
        @games.favorite_opponent(team_id)
    end
    
    def rival(team_id)
        @games.rival(team_id)
    end
end
