require 'CSV'
require_relative './game'

class GameCollection
  attr_reader :games

  def self.load_data(path)
    games = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|

      games[row[:game_id]] = Game.new(row)
    end

    GameCollection.new(games)
  end

  def initialize(games)
    @games = games
  end

  def highest_score
    highest = @games.values.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest.away_goals + highest.home_goals
  end

  def lowest_score
    lowest = @games.values.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest.away_goals + lowest.home_goals
  end

  def blowout
    biggest = @games.values.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
    (biggest.away_goals - biggest.home_goals).abs
  end

  def percent_home_wins
    percent = @games.values.count do |game|
      game.home_goals > game.away_goals
    end
    (percent.to_f / @games.length).round(2)
  end

  def percent_visitor_wins
    percent = @games.values.count do |game|
      game.home_goals < game.away_goals
    end
    (percent.to_f / @games.length).round(2)
  end

  def percent_ties
    percent = @games.values.count do |game|
      game.home_goals == game.away_goals
    end
    (percent.to_f / @games.length).round(2)
  end

  def seasons
    seasons = @games.values.map do |game|
      game.season
    end
    seasons.uniq.sort
  end

  def games_by_season
    seasons.reduce({}) do |season_game, season|
      games_in_season = @games.values.find_all do |game|
        game.season.include?(season)
      end
      season_game[season] = games_in_season
      season_game
    end
  end

  def count_of_games_by_season
    @games.values.reduce(Hash.new(0)) do |count_in_season, game|
      count_in_season[game.season] += 1
      count_in_season
    end
  end

  def avg_goals_per_game
    total = @games.values.sum do |game|
      game.home_goals + game.away_goals
    end
    (total.to_f / @games.values.length).round(2)
  end

  def avg_goals_in_season
    goals = {}
    games_by_season.each do |season, games|
      total = goals[season] = games.sum do |game|
        game.home_goals + game.away_goals
      end
      goals[season] = (total.to_f / games.length).round(2)
    end
    goals
  end

  # def allowed(fewest_allowed_goals)
  #   min_allowed = @games.find do |game_id, game|
  #    fewest_allowed_goals == game.away_team_id
  #   end
  #
  #   min_allowed[1].home_team_id
  # end
  
    # def opponent_of_team(team_id)
  #   x = @games.reduce do |game_id, game|
  #     if team_id == game.home_team_id
  # 

end
