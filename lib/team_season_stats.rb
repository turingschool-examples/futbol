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
#h1.merge(h2) {|key, oldval, newval| newval - oldval}
  def win_percentage(id)
    wins = wins_in_season(id)
    total = total_games_per_season(id)
    wins.merge(total) do |season, wins, games|
      (wins.to_f/games).round(2) * 100
    end
  end

  def best_season(id)
    win_percentage(id).max_by do |season, percentage|
      percentage
    end.first
  end

  def worst_season(id)
    win_percentage(id).min_by do |season, percentage|
      percentage
    end.first
  end

  def opponent_stats(id)
    total_games = all_games(id)
    #h = Hash.new { |h, k| h[k] = [] }
    opponent_hash = Hash.new{|id, games| id[games] = []}
    total_games.each do |game|
      opponent_hash[game.home_team_id] << game
      opponent_hash[game.away_team_id] << game
      opponent_hash.delete(id)
    end
    opponent_hash
  end

  def opponent_total_games_played(id)
    opponent_stats(id).reduce({}) do |total, (id, games)|
    total[id] = games.length
    total
    end
  end

  def opponent_wins(id)
    opponent_stats(id).reduce(Hash.new(0)) do |opponent_wins, (id, games)|
      wins = games.count do |game|
        home_wins = game.home_team_id == id && game.home_team_win?
        away_wins = game.away_team_id == id && game.visitor_team_win?
        home_wins || away_wins
      end
      opponent_wins[id] += wins
      opponent_wins
    end
  end

  def opponent_win_percentage(id)
    wins = opponent_wins(id)
    total = opponent_total_games_played(id)
    wins.merge(total) do |id, wins, games|
      (wins.to_f/games).round(2) * 100
    end
  end

  def favorite_opponent(id)
    opponent_win_percentage(id).min_by do |id, percentage|
      percentage
    end.first
  end

  def rival(id)
    opponent_win_percentage(id).max_by do |id, percentage|
      percentage
    end.first
  end
end
