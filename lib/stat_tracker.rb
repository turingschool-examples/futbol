require 'CSV'
require './lib/game.rb'
require './lib/game_factory.rb'
require './lib/team.rb'
require './lib/teams_factory.rb'
require './lib/game_team.rb'
require './lib/game_team_factory.rb'

class Stattracker
  attr_reader :game_teams_factory,
              :teams_factory,
              :game_factory

  def initialize
      @game_teams_factory = GameTeamFactory.new
      @teams_factory = Teams_factory.new    
      @game_factory = GameFactory.new
  end

  def self.from_csv(source)
    stattracker = Stattracker.new

    source.each do |key, value|
        case key
        when :games
          stattracker.game_factory.create_games(value)
        when :teams
          stattracker.teams_factory.create_teams(value)
        when :game_teams
          stattracker.game_teams_factory.create_game_teams(value)
        end
      end
      stattracker 
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
          
    percentage = (home_wins.to_f / total_games) * 100
    percentage.round(2)
  end
end