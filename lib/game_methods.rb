# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :table, :home_goals, :away_goals

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
    @home_goals = @table['home_goals']
    @away_goals = @table['away_goals']
<<<<<<< HEAD
=======
    @seasons = @table['season']
    @game_ids = @table['game_id']
>>>>>>> b3e23eaa64892fe04f59e7322df71817ee4d3521
  end

  def create_table
    CSV.parse(File.read(@file_loc), headers: true)
  end

  def highest_total_score
    home_goals = @table['home_goals']
    game_totals = @table['away_goals'].map.with_index do |away, idx|
      away.to_i + home_goals[idx].to_i
    end

    game_totals.max
  end

  def lowest_total_score
    home_goals = @table['home_goals']
    game_totals = @table['away_goals'].map.with_index do |away, idx|
      away.to_i + home_goals[idx].to_i
    end

    game_totals.min
  end

  def average_goals_per_game
    total_goals = @away_goals.map(&:to_i).sum + @home_goals.map(&:to_i).sum
    (total_goals.to_f / @away_goals.length).round(2)
  end

  def games_by_season
    @game_ids.group_by.with_index do |id, idx|
      @seasons[idx]
    end
  end

  def count_of_games_by_season
    output_hash = {}
    season_games = games_by_season
    season_games.keys.each do |season|
      output_hash[season] = season_games[season].length
    end
    output_hash
  end

  def determine_winner(index)
    if @home_goals[index] > @away_goals[index]
      :home
    elsif @home_goals[index] < @away_goals[index]
      :away
    else
      :tie
    end
  end

  def percentage_ties
    ties = (1..@away_goals.length).count do |game|
      :tie == determine_winner(game - 1)
    end
    (ties.to_f / @away_goals.length).round(2)
    if @home_goals[index] > @away_goals[index]
      :home
    elsif @home_goals[index] < @away_goals[index]
      :away
    else
      :tie
    end
  end

  def percentage_visitor_wins
    away_wins = (1..@away_goals.length).count do |game|
      :away == determine_winner(game - 1)
    end
    (away_wins.to_f / @away_goals.length).round(2)
  end

  def percentage_home_wins
    home_wins = (1..@home_goals.length).count do |game|
      :home == determine_winner(game - 1)
    end
    (home_wins.to_f / @home_goals.length).round(2)
  end
end
