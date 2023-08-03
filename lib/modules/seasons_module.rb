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
    home_wins = GameTeam.game_teams.count { |game| game.hoa == "home" && game.result == "WIN" }
    (home_wins.to_f / total_games_played.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = GameTeam.game_teams.count { |game| game.hoa == "away" && game.result == "WIN" }
    (away_wins.to_f / total_games_played.to_f).round(2)
  end

  def percentage_ties
    ties = GameTeam.game_teams.count { |game| game.result == "TIE" }/2
    (ties.to_f / total_games_played.to_f).round(2)
  end

  def count_of_games_by_season
    Season.seasons.each_with_object({}) { |season, hash| hash[season.season] = season.game_id.count }
  end

  def average_goals_per_game
    away_goals = Season.seasons.map { |season| season.away_goals.map(&:to_i) }.flatten
    home_goals = Season.seasons.map { |season| season.home_goals.map(&:to_i) }.flatten
    totals = [away_goals, home_goals].transpose.sum { |each| each.sum }
    (totals.to_f / total_games_played.to_f).round(2)
  end

  def average_goals_by_season
    Season.seasons.each_with_object({}) do |season, hash| 
      away = season.away_goals.map(&:to_i)
      home = season.home_goals.map(&:to_i)
      total = [away, home].transpose.sum { |each| each.sum }
      hash[season.season] = (total.to_f / season.game_id.count.to_f).round(2)
    end
  end

  def most_tackles(request_season)
    the_season = SeasonGameID.games.select { |game| game.season == request_season }
    just_game_id = the_season.map { |game| game.game_id }

    highest_tackles = 0
    highest_team_id = nil
    GameTeam.game_teams.each do |game| if game.tackles.to_i > highest_tackles && just_game_id.include?(game.game_id)
      highest_tackles = game.tackles.to_i
      highest_team_id = game.team_id
      end
    end
    highest_team_id
  end
end