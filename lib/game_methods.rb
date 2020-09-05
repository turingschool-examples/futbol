# frozen_string_literal: true

require 'CSV'

# Holds methods that get data out of a CSV file
class GameMethods
  attr_reader :file_loc, :table

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

  def determine_winner(index)
    if @home_goals[index] > @away_goals[index]
      :home
    elsif @home_goals[index] < @away_goals[index]
      :away
    else
      :tie
    end
  end

  def percentage_home_wins
    home_wins = (1..@home_goals.length).count do |game|
      :home == determine_winner(game - 1)
    end
    (home_wins.to_f / @home_goals.length).round(2)
  end
end
