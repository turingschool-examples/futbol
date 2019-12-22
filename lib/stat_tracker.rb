require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'season'
require_relative 'collection'
require_relative 'game_collection'
require_relative 'team_collection'
require_relative 'game_teams_collection'
require_relative 'season_collection'

class StatTracker
  attr_reader :game_collection,
              :team_collection,
              :season_collection,
              :game_teams_collection

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @game_collection = GameCollection.new(games)
    @team_collection = TeamCollection.new(teams)
    @season_collection = SeasonCollection.new(games)
    @game_teams_collection = GameTeamsCollection.new(game_teams)
  end

  def average_goals_per_game
    sum = 0
    @game_collection.collection.each do |game|
      sum += (game[1].away_goals.to_i + game[1].home_goals.to_i)
    end
    (sum.to_f / @game_collection.collection.length).round(2)
  end

  def average_goals_by_season
    sums = {}
    averages = {}
    @game_collection.collection.each do |game|
      if !sums.key?(game[1].season)
        sums[game[1].season] = (game[1].home_goals.to_i + game[1].away_goals.to_i)
      else
        sums[game[1].season] += (game[1].home_goals.to_i + game[1].away_goals.to_i)
      end
    end

    sums.each do |key, value|
      averages[key] = (value.to_f / count_of_games_by_season[key]).round(2)
    end

    averages
  end

  def highest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.min
  end

  def biggest_blowout
    blowout = {}
    @game_collection.collection.each do |game|
      margin = (game[1].home_goals.to_i - game[1].away_goals.to_i).abs
      if blowout.empty?
        blowout[game[1]] = margin
      elsif margin > blowout.values[0]
        blowout.clear
        blowout[game[1]] = margin
      end
    end
    blowout.values.last
  end

  def count_of_games_by_season
    season = Hash.new(0)
    @game_collection.collection.each do |game|
      season[game[1].season] += 1
    end
    season
  end

  def percentage_ties
    ties_sum = 0.0
    @game_collection.collection.each do |game|
      ties_sum += 1 if game[1].home_goals == game[1].away_goals
    end
    (ties_sum / @game_collection.collection.length).round(2)
  end

  def percentage_home_wins
    home_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        home_wins += 1
      end
    end
    (home_wins / total_games.to_f).abs.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|       
      if game[1].home_goals.to_i < game[1].away_goals.to_i
        visitor_wins += 1
      end
    end
    (visitor_wins / total_games.to_f).abs.round(2)
  end

  def count_of_teams
    @teams_collection.collection.length
  end

  def best_offense
    # create hash of teams to their total scores across all games
    # will move to helper method later
    team_total_scores = @games_collection.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].home_goals.to_i
      scores[game[1].away_team_id] += game[1].away_goals.to_i
      scores
    end

    game_count = @games_collection.collection.inject(Hash.new(0)) do |count, game|
      count[game[1].home_team_id] += 1
      count[game[1].away_team_id] += 1
      count
    end

    

    require 'pry'; binding.pry

    # @games_collection.collection.map do |game|
    #   if goals_scored.has_key?(game[1].away_team_id)
    #     goals_scored[game[1].away_team_id] << game[1].away_goals.to_i
    #   elsif !goals_scored.has_key?(game[1].away_team_id)
    #     goals_scored[game[1].away_team_id] = [game[1].away_goals.to_i]
    #   end
    # end

    # @games_collection.collection.map do |game|
    #   if goals_scored.has_key?(game[1].home_team_id)
    #     goals_scored[game[1].home_team_id] << game[1].home_goals.to_i
    #   elsif !goals_scored.has_key?(game[1].home_team_id)
    #     goals_scored[game[1].home_team_id] = [game[1].home_goals.to_i]
    #   end
    # end
    # team_names_ids = Hash.new(0)

    # @teams_collection.collection.each do |team|
    #   team_names_ids[team[1].team_id] = team[1].abbreviation
    # end
    #   goals_scored.each do |team|
    #     goals_scored_averages = team[1].sum / team[1].length
    #     goals_scored[team[0]] = goals_scored_averages
    # end
    # team_id_max_goals = goals_scored.max_by{ |k, v| v}
    # team_names_ids[team_id_max_goals[0]]
  end
end
