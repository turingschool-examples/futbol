require_relative './game_collection'
require_relative './game'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_collection = game_collection
  end

  def game_collection
     GameCollection.new(@game_path)
  end

  def percentage_home_wins
    (@game_collection.games.count {|game| game.home_goals > game.away_goals} / @game_collection.games.size.to_f).round(2)
  end

  def percentage_visitor_wins
    (@game_collection.games.count {|game| game.away_goals > game.home_goals} / @game_collection.games.size.to_f).round(2)
  end

  def percentage_ties
    (@game_collection.games.count {|game| game.away_goals == game.home_goals} / @game_collection.games.size.to_f).round(2)
  end

  def average_goals_by_season
    game_per_season = @game_collection.games.group_by{|game| game.season}
    game_per_season.reduce({}) do |result, season|
      sum_goals = season[1].sum do |game|
        game.away_goals + game.home_goals
      end
      result[season[0]] = (sum_goals/season[1].size.to_f).round(2)
      result
    end
  end

  def highest_total_score
    highest_scoring_game = @game_collection.games.max_by do |game|
      game.home_goals + game.away_goals
    end
    highest_scoring_game.home_goals + highest_scoring_game.away_goals
  end

  def lowest_total_score
    lowest_scoring_game = @game_collection.games.min_by do |game|
      game.home_goals + game.away_goals
    end
    lowest_scoring_game.home_goals + lowest_scoring_game.away_goals
  end

  def biggest_blowout
    blowout = @game_collection.games.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (blowout.home_goals - blowout.away_goals).abs
  end

  def games_per_season
    games_per_season_hash = @game_collection.games.group_by {|game| game.season}
    games_per_season_hash.reduce({}) do |new_hash, game|
      new_hash[game[0]] = game[1].length
      new_hash
    end
  end


end
