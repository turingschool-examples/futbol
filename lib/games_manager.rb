require_relative './game'

class GamesManager
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Game.new(row)
    end
    list_of_data
  end

  def highest_total_score
    total_scores = games.map do |game|
      game.away_goals + game.home_goals
    end.max
  end

  def lowest_total_score
    total_scores = games.map do |game|
      game.away_goals + game.home_goals
    end.min
  end

  def percentage_home_wins  #failed spec Harness
    home_wins = 0.0
    games.each do |game|
      home_wins += 1 if game.away_goals < game.home_goals
    end
    # require "pry"; binding.pry
    (home_wins/games.count).round(2)
  end

  def count_of_games_by_season
    count = Hash.new
    games.each do |game|
      if count[game.season].nil?
        count[game.season] = 1
      else
        count[game.season] += 1
      end
    #for each game, if no existing season id key, we create a new key and set value = 1.
    #if season key exists, increment value by 1
    end
    # require "pry"; binding.pry
    count
  end

  # require "pry"; binding.pry
end
