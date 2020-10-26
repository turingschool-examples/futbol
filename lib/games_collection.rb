require './lib/game'

class GamesCollection
  attr_reader :games

  def initialize(file_path)
    @games = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)
    end
  end

  def home_wins
    games.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def visitor_wins
    games.count do |game|
      game.home_goals < game.away_goals
    end
  end

  def ties
    games.count do |game|
      game.home_goals == game.away_goals
    end
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    games.each do |game|
      seasons[game.season] += 1
    end
    seasons
  end

  def average_goals_per_game
    total_goals = games.sum do |game|
      game.total_score
    end
    (total_goals.to_f / games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new(0)
    games.each do |game|
      seasons[game.season] += game.total_score
    end
    count_of_games_by_season.merge(seasons) do |key, games_count, total_goals|
      (total_goals.to_f / games_count).round(2)
    end
  end
end
