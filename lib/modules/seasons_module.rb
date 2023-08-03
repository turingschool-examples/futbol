require './lib/helper_class'

module Seasons
  def Season.best_offense
    require 'pry';binding.pry
    combined_games = Season.seasons.group_by { |game| team[:game_id] }
  end

  def highest_total_score
    away_goals = Season.seasons.map { |season| season.away_goals.map(&:to_i) }.flatten
    home_goals = Season.seasons.map { |season| season.home_goals.map(&:to_i) }.flatten
    totals = [away_goals, home_goals].transpose.map { |each| each.sum }
    totals.max
  end

  def lowest_total_score
    away_goals = Season.seasons.map { |season| season.away_goals.map(&:to_i) }.flatten
    home_goals = Season.seasons.map { |season| season.home_goals.map(&:to_i) }.flatten
    totals = [away_goals, home_goals].transpose.map { |each| each.sum }
    totals.min
  end
end