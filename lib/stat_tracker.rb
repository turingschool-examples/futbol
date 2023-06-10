require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'

class StatTracker 

  def from_csv(path)
    if path == './data/games.csv'
    @game_factory = create_games_factory(path)
    elsif path == './data/teams.csv'
      @team_factory = create_teams_factory(path)
    else
      @game_teams_factory = create_game_teams_factory(path)
    end
  end

  def create_teams_factory(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    team_factory
  end
  
  def create_games_factory(path)
    game_factory = GameFactory.new
    game_factory.create_games(path)
    game_factory
  end

  def create_game_teams_factory(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    game_teams_factory
    # require 'pry'; binding.pry
  end

  def percentage_home_wins
    @game_factory.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_factory.percentage_visitor_wins
  end

  def percentage_ties
    @game_factory.percentage_ties
  end

end
