require 'csv'
require_relative 'game'
require_relative 'team_collection'

class GameCollection
  attr_reader :game_instances, :game_path

  def initialize(game_path)
    @game_path = game_path
    @game_instances = all_games
  end

  def all_games
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       Game.new(row)
    end
  end

  def count_of_games_by_season
    season_game_count = Hash.new(0)
    @game_instances.each do |game|
      season_game_count[game.season] += 1
    end
    season_game_count
  end

  # Returns an array that contains every game score both winners and losers added together
    def total_scores
      total_scores_array = []
        @game_instances.each do |game|
          total_goals = game.away_goals + game.home_goals
          total_scores_array << total_goals
        end
      total_scores_array
    end

  # Returns the sum of both teams score for the highest scoring game
    def highest_total_score
      total_scores.uniq.max
    end

  # Returns the sum of both teams score for the lowest scoring game
    def lowest_total_score
      total_scores.uniq.min
    end

  # Returns the biggest blowout difference between scores
    def biggest_blowout
      difference = @game_instances.map do |game|
        (game.away_goals - game.home_goals).abs
      end
      difference.uniq.max
    end

  def average_goals_per_game
    goals = @game_instances.sum do |game|
      game.home_goals + game.away_goals
    end
    (goals.to_f / @game_instances.length).round(2)
  end

  def average_goals_by_season
    ave_season_goals = Hash.new(0)
    @game_instances.each do |game|
      ave_season_goals[game.season] += (game.away_goals.to_f + game.home_goals)
    end
    ave_season_goals.each do |key, value|
        ave_season_goals[key] = (value / count_of_games_by_season[key]).round(2)
    end
  end

  def home_wins
    @game_instances.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def visitor_wins
    @game_instances.count do |game|
      game.home_goals < game.away_goals
    end
  end

  def ties
    @game_instances.count do |game|
      game.home_goals == game.away_goals
    end
  end

  def worst_defense
    all_team_ids = TeamCollection.new('./dummy_data/dummy_teams.csv')
    # team_ids = []
    # @team_instances.each do |instance|
    #   team_ids << instance.team_id
    # end
    # require "pry"; binding.pry
    # team_ids.uniq!
    team_ids = all_team_ids.array_of_team_ids
    team_id_goals_against = Hash.new(0)
    team_ids.each do |id|
      @game_instances.each do |instance|
        if id == instance.home_team_id
          team_id_goals_against[id] += instance.away_goals
        elsif id == instance.away_team_id
          team_id_goals_against[id] += instance.home_goals
        end
      end
    end
    team_id_goals_against
    worst_team_hash = team_id_goals_against.select { |k, v| v == team_id_goals_against.values.max }
    worst_team_hash.keys
  end

  def best_defense
    all_team_ids = TeamCollection.new('./dummy_data/dummy_teams.csv')
    # team_ids = []
    # @team_instances.each do |instance|
    #   team_ids << instance.team_id
    # end
    # require "pry"; binding.pry
    # team_ids.uniq!
    team_ids = all_team_ids.array_of_team_ids
    team_id_goals_against = Hash.new(0)
    team_ids.each do |id|
      @game_instances.each do |instance|
        if id == instance.home_team_id
          team_id_goals_against[id] += instance.away_goals
        elsif id == instance.away_team_id
          team_id_goals_against[id] += instance.home_goals
        end
      end
    end
    team_id_goals_against
    best_team_hash = team_id_goals_against.select { |k, v| v == team_id_goals_against.values.min }
    best_team_hash.keys
  end

end
