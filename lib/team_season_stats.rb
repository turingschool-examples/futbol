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

  def count_all_games_in_season(id)
  def total_games_per_season(id)
    all_games_by_season(id).reduce({}) do |total, (season, games)|
      total[season] = games.length
      total
    end
  end

  def wins_in_season(id)
    all_games_by_season(id).reduce(Hash.new(0)) do |season_wins, (season, games)|
      wins = games.count do |game|
        home_wins = game.home_team_id == id && game.home_team_win?
        away_wins = game.away_team_id == id && game.visitor_team_win?
        home_wins || away_wins
      end
        season_wins[season] += wins
        season_wins
    end
  end
end
