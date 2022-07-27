require_relative './teams'
require_relative './game'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :game_path,
              :team_path,
              :game_teams_path,
              :locations

  def initialize(games, teams, game_teams)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @games = Game.create_multiple_games(@locations[:games])
    @teams = Teams.create_multiple_teams(@locations[:teams])
    @game_teams = GameTeams.create_multiple_game_teams(@locations[:game_teams])
  end


  def self.from_csv(locations)
    @games
    @teams
    @game_teams
    StatTracker.new(@games, @teams, @game_teams)
  end

  def highest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.max
  end

  def lowest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.min
  end

  def percentage_home_wins
    numerator = @games.find_all {|game| game.home_goals.to_i > game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_visitor_wins
    numerator = @games.find_all {|game| game.home_goals.to_i < game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_ties
    numerator = @games.find_all {|game| game.home_goals.to_i == game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    total_goals_per_game = []
       @games.map do |game|
        total_goals_per_game << [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    ((total_goals_per_game.sum.to_f)/(@games.size)).round(2)
  end

  def average_goals_by_season
    hash = Hash.new(0)
    n = 0
    @games.each do |game|
      require 'pry' ; binding.pry
      n += 1
      hash[game.season] += ((game.home_goals.to_i + game.away_goals.to_i)/(n.to_f)).round(2)
    end
    hash
  end

end
