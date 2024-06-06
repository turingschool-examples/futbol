require 'csv'
require_relative 'team'
require_relative 'game_team'
require_relative 'league'
require_relative 'game'
require_relative 'season'
require_relative 'game_stat'

class StatTracker
  attr_reader :team_data, :games, :game_teams_data, :league, :season, :game_stats 

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @team_data = create_objects(locations[:teams], Team, self)   
    @games = create_objects(locations[:games], Game, self)   
    @game_teams_data = create_objects(locations[:game_teams], GameTeam, self)   
    @game_stats = GameStats.new(@games)
    # binding.pry
  end

  def create_objects(path, obj_class, parent_self)
   data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
   data.map {|d| obj_class.new(d)}
  end
end