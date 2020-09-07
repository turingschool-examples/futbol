# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :table

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
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

  def average_goals_by_season
    rows = @table.group_by {|row| row['season']}
    output_hash = {}
    rows.each do |season, games|
      output_hash[season] = (games.sum do |row|
        row['away_goals'].to_i + row['home_goals'].to_i
      end.to_f / games.length).round(2)
    end
    output_hash
  end
end
