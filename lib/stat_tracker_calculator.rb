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


end