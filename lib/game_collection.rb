require_relative 'game'
require_relative '../modules/mathables'

class GameCollection
  include Mathable
  attr_reader :games
  def initialize(game_data)
    @games = create_games(game_data)
  end

  def create_games(game_data)
    game_data.map do |row|
      Game.new(row.to_h)
    end
  end

  def highest_total_score
    @games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def biggest_blowout
    @games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end
    divide(home_wins.length, @games)
  end

  def percentage_visitor_wins
    visitor_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end
    divide(visitor_wins.length, @games)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game.home_goals == game.away_goals
    end
    divide(ties.length, @games)
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
      @games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end

  def average_goals_per_game
    total_goals_per_game = @games.map do |game|
      game.home_goals + game.away_goals
    end
    divide(total_goals_per_game.sum, @games)
  end

  def average_goals_by_season
    games_grouped_by_season = @games.group_by { |game| game.season }
    games_grouped_by_season.each_pair do |season, games_by_season|
      total_goals = games_by_season.map do |single_game|
        single_game.home_goals + single_game.away_goals
      end
    games_grouped_by_season[season] = divide(total_goals.sum, total_goals)
    end
  end

  def total_games_by_team
    games_by_team = Hash.new(0)
    @games.each do |game|
      games_by_team[game.away_team_id] += 1
      games_by_team[game.home_team_id] += 1
    end
    games_by_team
  end

  def all_goals_allowed_by_team
    goals_allowed_by_team = Hash.new(0)
    @games.each do |game|
      goals_allowed_by_team[game.away_team_id] += game.home_goals
      goals_allowed_by_team[game.home_team_id] += game.away_goals
    end
    goals_allowed_by_team
  end

  def defense_rankings
    avg_goals_allowed = {}
    all_goals_allowed_by_team.each do |team_id, goals_allowed|
      avg_goals_allowed[team_id] = goals_allowed / total_games_by_team[team_id].to_f
    end
    avg_goals_allowed
  end

  def total_scores_by_team(team_num)
    games.reduce([]) do |scores, game|
      if team_num.to_i == game.home_team_id
        scores << game.home_goals
      elsif team_num.to_i == game.away_team_id
        scores << game.away_goals
      end
      scores
    end
  end
end
