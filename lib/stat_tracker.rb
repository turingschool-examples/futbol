# Sum up Away and Home team's score per game_id
# Get data by col
  # Col by winning score + Col by losing score
# Parse CSV table initially and save as instance variable
# Method will iterate through instance variable
require 'csv'

class StatTracker
  attr_reader :games, :game_teams, :teams
  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = locations[:games]
    @game_teams = locations[:game_teams]
    @teams = locations[:teams]
  end

  def highest_total_score # Rename later, for now from Games Table
    most = 0
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:away_goals].to_i + row[:home_goals].to_i
      most = total if total > most
    end
    most
  end

  def lowest_total_score
    least = 1000
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:home_goals].to_i + row[:away_goals].to_i
      least = total if total < least
    end
    least
  end

  def percentage_home_wins
    home_wins = 0
    visitor_wins = 0
    ties = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(home_wins, total_games)
  end

  def percentage_visitor_wins
    home_wins = 0
    visitor_wins = 0
    ties = 0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(visitor_wins, total_games)
  end

  def percentage_ties
    home_wins = 0
    visitor_wins = 0
    ties = 0.0
    CSV.foreach(game_teams, headers: true, header_converters: :symbol) do |row|
      next if row[:result] == "LOSS"
      if row[:result] == "TIE"
        ties += 0.5
      elsif row[:hoa] == "away"
        visitor_wins += 1
      elsif row[:hoa] == "home"
        home_wins += 1
      end
    end
    total_games = home_wins + visitor_wins + ties
    percentage = calc_percentage(ties, total_games)
  end

  def count_of_games_by_season
    season_games = {}
    CSV.foreach(games, headers: true, header_converters: :symbol) do |row|
      if season_games.key?(row[:season]) 
        season_games[row[:season]] += 1
      else
        season_games[row[:season]] = 1
      end
      # require 'pry'; binding.pry
    end
    season_games
  end

  def calc_percentage(numerator, denominator)
    (numerator.to_f / denominator * 100).round(2)
  end
end
