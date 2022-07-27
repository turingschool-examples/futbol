require 'csv'


class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = read_data(games)
    @teams = read_data(teams)
    @game_teams = read_data(game_teams)
    #require "pry"; binding.pry
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.open(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.open(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end

  def read_data(data)
    list_of_data = []
    data.each do |row|
      list_of_data << row
    end
    list_of_data
  end

  def highest_total_score
    max = @games.max_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    max[:away_goals].to_i + max[:home_goals].to_i
  end

  def lowest_total_score
    min = @games.min_by { |game| game[:away_goals].to_i + game[:home_goals].to_i }
    min[:away_goals].to_i + min[:home_goals].to_i
  end

  def percentage_home_wins
    wins = @games.count { |game| game[:home_goals].to_i > game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_visitor_wins
    wins = @games.count { |game| game[:home_goals].to_i < game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def percentage_ties
    wins = @games.count { |game| game[:home_goals].to_i == game[:away_goals].to_i}
    games = @games.count
    (wins / games.to_f).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new
    @games.each do |game|
      if seasons[game[:season]]
        seasons[game[:season]] += 1
      else
        seasons[game[:season]] = 1
      end
    end
    seasons
  end

  def average_goals_per_game
    (@games.sum { |game| game[:away_goals].to_f + game[:home_goals].to_f } / @games.count).round(2)
  end
end
