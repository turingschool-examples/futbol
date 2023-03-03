require 'csv' 
require_relative 'team'
require_relative 'game'
require_relative 'game_teams'



class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(files)
   StatTracker.new(files)
  end

  def initialize(files)
    @game_stats = GameStats.new(files)
    @league_stats = LeagueStats.new(files)
    @season_stats = SeasonStats.new(files)
  end

  # Game Stats
    def highest_total_score
      @game_stats.highest_total_score
    end

    def lowest_total_score
      @game_stats.lowest_total_score
    end

    def percentage_home_wins
      @game_stats.percentage_home_wins
    end

    def percentage_visitor_wins
      @game_stats.percentage_visitor_wins
    end

    def percentage_ties
      @game_stats.percentage_ties
    end

    def count_of_games_by_season
      @game_stats.count_of_games_by_season
    end

    def average_goals_per_game
      @game_stats.average_goals_per_game
    end

    def average_goals_by_season
      @game_stats.average_goals_by_season
    end

  # League Stats
  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end
  # Season Stats

end