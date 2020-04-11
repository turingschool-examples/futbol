require 'csv'
require_relative 'collection'

class TeamSeasonStats < Collection
  attr_reader :team_stats

  def initialize(file_path)
    @games = create_objects(file_path, Game)
  end

  def all_games(id)
    @games.find_all do |game|
      (game.home_team_id == id) || (game.away_team_id == id)
    end
  end

  def all_games_by_season(id)
    games_by_season = all_games(id).group_by {|game| game.season}
    games_by_season
  end

#count all of the games per season for team searched
#take the allgamesbyseason hash
#{season => [games]}
  def count_all_games_in_season(id)
    all_games_by_season(id).reduce({}) do |total, (season, games)|
      total[season] = games.count
      total
    end
  end
end
#
# def count_of_all_wins_by_season_for(id)
#    all_games_by_season_for(id).reduce(Hash.new(0)) do |acc, (season, games)|
#      wins = games.count do |game|
#        (game.home_team_id == id && game.home_team_win?) ||
#        (game.away_team_id == id && game.visitor_team_win?)
#      end
#      acc[season] += wins
#      acc
#    end
#  end
#
#  def win_percentage_by_season_for(id)
#    season_wins = count_of_all_wins_by_season_for(id)
#    season_games = count_of_all_games_by_season_for(id)
#    season_wins.merge(season_games) do |season, wins, games|
#      (wins.to_f / games).round(2)
#    end
#  end
#
#  def highest_season_win_percentage_for(id)
#    win_percentage_by_season_for(id).max_by do |season, percentage|
#      percentage
#    end.first
#  end
#
#  def lowest_season_win_percentage_for(id)
#    win_percentage_by_season_for(id).min_by do |season, percentage|
#      percentage
#    end.first
