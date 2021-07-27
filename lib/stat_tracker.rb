require 'CSV'
require 'pry'
class StatTracker

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(file_paths)
    games = CSV.read(file_paths[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(file_paths[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(file_paths[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

  # Game statistics ------------------------------------------------------------

  def highest_total_scores
    highest = 0
    @games.each do |game|
      sum = game[:away_goals].to_i + game[:home_goals].to_i
      highest = sum if sum > highest
    end
    highest
  end

  def lowest_total_scores
    lowest = games.first[:away_goals].to_i + games.first[:home_goals].to_i
    @games.each do |game|
      sum = game[:away_goals].to_i + game[:home_goals].to_i
      lowest = sum if sum < lowest
    end
    lowest
  end

  def percentage_home_wins
    home_games = 0
    home_wins = 0
    @game_teams.each do |game_team|
      if game_team[:hoa] == 'home' && game_team[:result] == 'WIN'
        home_wins += 1
        home_games += 1
      elsif game_team[:hoa] == 'home'
        home_games += 1
      end
    end
    (home_wins.to_f / home_games.to_f).round(2)
  end

end
