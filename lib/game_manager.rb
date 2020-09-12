require_relative '../lib/findable'

class GameManager
  include Findable
  attr_reader :games, :tracker #do we need attr_reader?

  def initialize(path, tracker)
    @games = []
    @tracker = tracker
    create_games(path)
  end

  def create_games(path)
    games_data = CSV.read(path, headers:true) #may need to change .read to .load

    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  #------------SeasonStats

  def games_of_season(season)
    @games.find_all {|game| game.season == season}
  end

  def find_game_ids_for_season(season)
    games_of_season(season).map {|game| game.game_id }
  end

  #------------LeagueStats
  def count_of_teams
    teams = games.flat_map do |game|
      [game.away_team_id, game.home_team_id]
    end
    teams.uniq.count
  end

  def best_offense
    best_offense = team_stats.max_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(best_offense[0])
  end

  def worst_offense
    worst_offense = team_stats.min_by do |team, stats|
      stats[:total_goals] / stats[:total_games].to_f
    end
    find_team_by_team_id(worst_offense[0])
  end

  def team_stats
    tracker.create_team_stats_hash.each do |team_id, games_goals|
      games.each do |game|
        if team_id == game.away_team_id || team_id == game.home_team_id
          games_goals[:away_games] += 1 if team_id == game.away_team_id
          games_goals[:home_games] += 1 if team_id == game.home_team_id
          games_goals[:away_goals] += game.away_goals.to_i if team_id == game.away_team_id
          games_goals[:home_goals] += game.home_goals.to_i if team_id == game.home_team_id
        end
      end
      games_goals[:total_games] = games_goals[:away_games] + games_goals[:home_games]
      games_goals[:total_goals] = games_goals[:away_goals] + games_goals[:home_goals]
    end
  end
end
