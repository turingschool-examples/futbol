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
      game.away_goals + game.home_goals # potential helper method
    end.max
  end

  def lowest_total_score
    total_scores = games.map do |game|
      game.away_goals + game.home_goals 
    end.min
  end

  def percentage_home_wins
    home_wins = 0.0
    games.each do |game|
      home_wins += 1 if game.away_goals < game.home_goals
    end
    (home_wins/games.count).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0.0
    games.each do |game|
      visitor_wins += 1 if game.away_goals > game.home_goals
    end
    (visitor_wins/games.count).round(2)
  end

  def percentage_ties
    ties = 0.0
    games.each do |game|
      ties += 1 if game.away_goals == game.home_goals
    end
    (ties/games.count).round(2)
  end

  def count_of_games_by_season
    @games_in_season = Hash.new
    games.each do |game|
      if @games_in_season[game.season].nil?
        @games_in_season[game.season] = 1
      else
        @games_in_season[game.season] += 1
      end
    end
    @games_in_season
  end

  def average_goals_per_game
    total_goals = games.sum do |game|
      game.away_goals + game.home_goals
    end.to_f
    (total_goals / games.count).round(2)
  end
  # make total goals an instance variable
  def average_goals_by_season
    goals = Hash.new
    all_seasons = []
    games.each do |game|
      if goals[game.season].nil?
        all_seasons << game.season
        goals[game.season] = (game.away_goals + game.home_goals)
      else
        goals[game.season] += (game.away_goals + game.home_goals)
      end
    end
    average = Hash.new
    all_seasons.each do |season|
      average[season] = (goals[season].to_f/@games_in_season[season]).round(2)
    end
    average
    #total number of goals in a season /
    #total number of games in a season

    #make count from count games by season into instance variable
    #nested iteration through both hashes to do the math one at a time

    # goals_in_season = Hash.new
    # test_hash = Hash.new(0)
    # games.each do |game|
    #   if goals_in_season[game.season].nil?
    #     goals_in_season[game.season] = (game.away_goals + game.home_goals)
    #   else
    #     goals_in_season[game.season] += (game.away_goals + game.home_goals)
    #   end
    # end
    # @games_in_season.each do |num_games|
    #   goals_in_season.map do |num_goals|
    #     test_hash[num_goals[0]] = num_goals[1] / num_games[1].to_f
    #   end
    # end
  end
end

