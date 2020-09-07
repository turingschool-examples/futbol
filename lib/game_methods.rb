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
end
