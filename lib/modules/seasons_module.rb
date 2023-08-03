require './lib/helper_class'

module Seasons

  def total_games_played
    Season.seasons.map { |season| season.game_id }.flatten.count
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

  def percentage_home_wins
    home_wins = GameTeam.game_teams.count { |game| game.hoa == "home" && game.result == "WIN"}
    (home_wins / total_games_played).round(2)
  end




end