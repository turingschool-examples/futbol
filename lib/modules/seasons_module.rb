require './lib/helper_class'

module Seasons
  def highest_total_score
    away_goals = Season.seasons.map { |season| season.away_goals }.flatten
    home_goals = Season.seasons.map { |season| season.home_goals }.flatten
    totals = [away_goals, home_goals].transpose.map { |each| each.sum }
    totals.max
  end


end