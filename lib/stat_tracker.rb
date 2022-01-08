require 'pry'
require 'CSV'
require './lib/games_collection'
require './lib/teams_collection'
require './lib/games_teams_collection'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations
    @games_file = GamesCollection.new(@locations[:games])
    @teams_file = TeamsCollection.new(@locations[:teams])
    @game_teams_file = GamesTeamsCollection.new(@locations[:game_teams])
    @read_games = @games_file.read_file
    @read_teams = @teams_file.read_file
    @read_game_teams = @game_teams_file.read_file

  end

  def self.from_csv(files) #add .to_a changes to an array\
    #binding.pry
    StatTracker.new(files) #creating an instance of StatTracker holding the hash as locations
  end

  def highest_total_score
    scores_array = [] #helper method later
    @read_games.each do |row|
      #binding.pry
      scores_array << row.home_goals.to_i + row.away_goals.to_i
    end
    scores_array.max
  end

  def lowest_total_score #helper method it later
    scores_array = []
    @read_games.each do |row|
      scores_array << row.away_goals.to_i + row.home_goals.to_i
    end
    scores_array.min
  end

  def percentage_home_wins
    games_played = 0
    wins = 0

     @read_game_teams.each do |game|
      if game.hoa == "home" && game.result == "WIN"
        games_played += 1
        wins += 1
      elsif game.hoa == "home" && game.result == "LOSS"
        games_played += 1
      end
    end
      (wins.to_f / games_played.to_f).round(2)
  end

  def percentage_away_wins
    games_played = 0
    wins = 0
     @read_game_teams.each do |game|
      if game.hoa == "away" && game.result == "WIN"
        games_played += 1
        wins += 1
      elsif game.hoa == "away" && game.result == "LOSS"
        games_played += 1
      end
    end
      (wins.to_f / games_played.to_f).round(2)
  end

  def percentage_ties
    games_played = 0
    ties = 0
     @read_game_teams.each do |game|
      if game.result == "TIE"
        games_played += 1
        ties += 1
      else
        games_played += 1
      end
    end
      (ties.to_f / games_played.to_f).round(2)
  end
end

  def percentage_visitor_wins
    games_played = 0
    wins = 0
     @read_games.each do |game|
      if game.away_goals.to_i > game.home_goals.to_i
        games_played += 1
        wins += 1
      elsif
        games_played += 1
      end
    end
    # binding.pry
      (wins.to_f / games_played.to_f).round(2)
  end

  def percentage_ties
    games_played = 0
    wins = 0
     @read_games.each do |game|
      if game.away_goals.to_i == game.home_goals.to_i
        games_played += 1
        wins += 1
      elsif
        games_played += 1
      end
    end
    # binding.pry
      (wins.to_f / games_played.to_f).round(2)
  end

  def count_of_games_by_season
    @games_by_season = {}

    seasons = @read_games.map do |game|
      game.season
    end.uniq
    games_seasons = @read_games.map do |game|
      game.season
    end
    seasons.each do |season|
      @games_by_season[season] = games_seasons.count(season)
    end
    @games_by_season
  end
  # binding.pry
  def average_goals_per_game
    @total_goals = 0
    @read_games.each do |home|
      @total_goals += (home.home_goals.to_f + home.away_goals.to_f)
    end
    (@total_goals.to_f / @read_games.count).round(2)
    # binding.pry
  end

  def average_goals_by_season
    @seasons = @read_games.map do |game|
      game.season
    end.uniq
    total_goals_by_season = Hash.new(0)
    @read_games.each do |game|
        total_goals_by_season[game.season] += (game.home_goals.to_f + game.away_goals.to_f)
    end
    average_goals_by_season = {} #Hash.new(0)

    # binding.pry
    @seasons.each do |w|
        average_goals_by_season[w] = (total_goals_by_season[w].to_f / count_of_games_by_season[w].to_f).round(2)
        # average_goals_by_season.transform_values! { |v| (total_goals_by_season[w].to_i / count_of_games_by_season[w].to_i)}
        # binding.pry
    end
    average_goals_by_season
  end
end
