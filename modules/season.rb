require './lib/game'
require './lib/game_teams'
require './lib/team_stats'
require 'pry'
# This mod will handle all season related methods
module Season
  def winningest_coach(season)
    victories = GameTeams.create_list_of_game_teams(@game_teams).find_all { |game| game.result == 'WIN' }
    games = games_by_season(season)
    wins_by_coach = {}
    victories.each do |win|
      next unless games.any? { |game| game.game_id == win.game_id }

      wins_by_coach[win.head_coach] = 1 if wins_by_coach[win.head_coach].nil?
      wins_by_coach[win.head_coach] += 1
    end
    wins_by_coach.sort_by { |_coach, wins| wins }.reverse[0][0]
  end

  def games_by_season(season)
    games = Game.create_list_of_games(@games)
    games.find_all { |game| game.season == season }
  end

  def worst_coach(season)
    victories = GameTeams.create_list_of_game_teams(@game_teams).find_all { |game| game.result == 'LOSS' }
    games = games_by_season(season)
    wins_by_coach = {}
    victories.each do |win|
      next unless games.any? { |game| game.game_id == win.game_id }

      wins_by_coach[win.head_coach] = 1 if wins_by_coach[win.head_coach].nil?
      wins_by_coach[win.head_coach] += 1
    end
    wins_by_coach.sort_by { |_coach, wins| wins }[0][0]
  end

  def most_accurate_team; end

  def least_accurate_team; end

  def most_tackles; end

  def fewest_tackles; end
end
