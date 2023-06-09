require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'


# require './lib/team_factory'
# require './lib/game_teams_factory'
# require './lib/game_factory'

class StatTracker 
  
  def initialize
    @teams = []
    @game_teams = []
  end

  def from_csv(path)
    if path == './data/games.csv'
      create_games_array(path)
    elsif path == './data/teams.csv'
      create_teams_array(path)
    else
      './data/game_teams.csv'
      create_game_teams_array(path)
    end
  end

  def create_teams_array(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    #require 'pry'; binding.pry
  end
  

  def create_games_array(path)
   game_factory = GameFactory.new
   game_factory.create_games(path)
   #require 'pry'; binding.pry
  end



  def create_game_teams_array(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    require 'pry'; binding.pry
  end

  
end
