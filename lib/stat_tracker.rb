require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'league_stat'
require_relative 'game'
require_relative 'season_stat'
require_relative 'game_stat'


class StatTracker
  attr_reader :team_data, 
              :games, 
              :game_teams_data, 
              :league, 
              :season, 
              :game_stats, 
              :league_stats,
              :season_stats
        

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @team_data = create_objects(locations[:teams], Team, self)   
    @games = create_objects(locations[:games], Game, self)   
    @game_teams_data = create_objects(locations[:game_teams], GameTeam, self)   
    @game_stats = GameStats.new(@games)
    @league_stats = LeagueStats.new(@game_teams_data, @team_data)

    @season_stats = SeasonStats.new(@game_teams_data, @team_data, @games)

    

  end

  def create_objects(path, obj_class, parent_self)
   data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
   data.map {|d| obj_class.new(d)}
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_games_in_seasons
    @game_stats.count_games_in_seasons
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_per_season
    @game_stats.average_goals_per_season
  end
end