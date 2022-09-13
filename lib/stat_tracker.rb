require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def highest_total_score
    #highest sum of winning and losing teams scores
    sum_goals_array = @games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    sum_goals_array.max
  end

  def lowest_total_score
    sum_goals_array = @games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
    sum_goals_array.min
  end

  def count_of_teams
    @teams.length
  end

  def return_column(data_set, column)
    all_results = []
    data_set.each do |rows|
      all_results << rows[column]
    end 
    all_results
  end

  def self.from_csv(locations)
   games = CSV.open locations[:games], headers: true, header_converters: :symbol
   teams = CSV.open locations[:teams], headers: true, header_converters: :symbol
   game_teams = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
   make_rows([games, teams, game_teams])
  end

  def self.make_rows(array)
    dummy_array = array.map do |file|
      file.map do |row|
        row
      end
    end
    StatTracker.new(dummy_array[0], dummy_array[1], dummy_array[2])
  end
end