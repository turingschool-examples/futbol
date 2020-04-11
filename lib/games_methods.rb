require_relative 'game'
require 'csv'
class Games
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
       Game.new(row)
    end
  end

  def highest_total_score
    #sums winning team score and losing team score for every game,
    #compares these and returns highest
    total_scores = []
    @games.each do |game|
      total_scores << (game.away_goals + game.home_goals)
    end
    total_scores.sort.last
  end

  def lowest_total_score
    #sums winning team score and losing team score for every game,
    #compares these and returns highest
    total_scores = []
    @games.each do |game|
      total_scores << (game.away_goals + game.home_goals)
    end
    total_scores.sort.first
  end

  def percentage_home_wins
    count = 0
    @games.each do |game|
      if game.home_goals > game.away_goals
        count += 1
      end
    end
    ((count/(games.count.to_f))*100).round(2)
  end

  def percentage_visitor_wins
    count = 0
    @games.each do |game|
      if game.away_goals > game.home_goals
        count += 1
      end
    end
    ((count/(games.count.to_f))*100).round(2)
  end

  def percentage_ties
    count = 0
    @games.each do |game|
      if game.away_goals == game.home_goals
        count += 1
      end
    end
    ((count/(games.count.to_f))*100).round(2)
  end

  def count_of_games_by_season
    hash = {}
    @games.each do |game|
      if hash[game.season] == nil
        hash[game.season] = 0
      end
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    total_goals = 0
    @games.each do |game|
      goals_per_game = game.home_goals + game.away_goals
      total_goals += goals_per_game
    end
    (total_goals.to_f/@games.length).round(3)
  end

  def average_goals_by_season
    hash = {}
    @games.each do |game|
      if hash[game.season] == nil
        hash[game.season] = 0
      end
      require "pry"; binding.pry
      hash[game.season] = game.home_goals + game.away_goals
      hash[game.season] += 1
    end
    hash
  end
end


### average_goals_by_season	### Average number of goals scored in a game organized
# in a hash with season names (e.g. 20122013) as keys and a float representing
#the average number of goals in a game for that season as a key (rounded to the nearest 100th)
