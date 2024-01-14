require_relative './game'
require_relative './game_factory'
require_relative './team'
require_relative './team_factory'
require_relative './game_teams'
require_relative './game_teams_factory'
class StatTrackerCalculator

  attr_accessor :game_path, 
                :team_path,
                :game_teams_path

  def initialize
    @game_path = ""
    @team_path = ""
    @game_teams_path = "" 
    @game_factory = "" #factory objects that will be initialized and brought through a different method
    @team_factory = ""
    @game_teams_factory = ""
  end

  def make_factories
    @game_factory = GameFactory.new(@game_path)
    @team_factory = TeamFactory.new(@team_path)
    @game_teams_factory = GameTeamFactory.new(@game_teams_path)
  end

  def use_factories
    @game_factory.create_games
    @team_factory.create_teams
    @game_teams_factory.create_game_team
  end

  def self.from_csv(locations) #will be a hash passed in from runner file
    stat_tracker = StatTracker.new
    stat_tracker.game_path = locations[:games] #changing object's attributes
    stat_tracker.team_path = locations[:teams]
    stat_tracker.game_teams_path = locations[:game_teams]
    stat_tracker.make_factories
    stat_tracker.use_factories
  end

  def highest_total_score
    @game_factory.total_score.max
  end

  def lowest_total_score
    @game_factory.total_score.min
  end

  def percentage_home_wins
    (@game_team_factory.game_result_by_hoa.count {|result| result == "home"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (@game_team_factory.game_result_by_hoa.count {|result| result == "away"}.to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def percentage_ties
    (@game_team_factory.game_results_count_by_result("TIE").to_f / @game_factory.count_of_games.to_f).round(2)
  end

  def count_of_games_by_season
    count_of_games_by_season = {}
    @game_factory.games.each do |game|
      count_of_games_by_season[game.season] = @game_factory.season_games(game.season)
    end
    count_of_games_by_season
  end

  def average_goals_per_game
    (@game_factory.total_score.sum.to_f / @game_factory.count_of_games.to_f).round(2)
  end
end