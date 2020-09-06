# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :table

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
    @seasons = @table['season']
    @game_ids = @table['game_id']
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
end
