require_relative './team'
require_relative './game'
require_relative './game_team'
require 'csv'
require 'pry'

class StatTracker

  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    teams = []
    CSV.read(locations[:teams]).each_with_index do |line, index|
      unless index == 0
        teams << Team.new(line)
      end
    end

    games = []
    CSV.read(locations[:games]).each_with_index do |line, index|
      unless index == 0
        games << Game.new(line)
      end
    end

    game_teams = []
    CSV.read(locations[:game_teams]).each_with_index do |line, index|
      unless index == 0
        game_teams << GameTeam.new(line)
      end
    end

    StatTracker.new(teams, games, game_teams)
  end


  def highest_total_score
    highest_game = @games.max_by do |game|
      game.away_goals + game.home_goals
    end

    highest_game.away_goals + highest_game.home_goals
  end

  def lowest_total_score
    lowest_game = @games.min_by do |game|
      game.away_goals + game.home_goals
    end

    lowest_game.away_goals + lowest_game.home_goals
  end



  def count_of_games_by_season
    count = Hash.new(0)

    @games.each do |game|
      count[game.season.to_s] += 1
    end

    count
  end




end
