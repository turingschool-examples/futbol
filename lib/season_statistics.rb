require './lib/stat_tracker'
require 'pry'

class SeasonStatistics
attr_reader :stat_tracker, :game_collection, :game_teams_collection, :teams_collection

  def initialize(game_collection, game_teams_collection, teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end

  def current_season_games(season)
    current_games = @game_collection.map do |game|
     if game.season == season
       game.game_id
     end
   end
   current_games.compact
  end

  def teams_hash
    teams = Hash.new(0)
    @teams_collection.each do |team|
      teams[team.id] = 0
    end
    teams
  end

  def coaches_hash
    coaches = Hash.new(0)
    @game_teams_collection.each do |team|
      coaches[team.head_coach] = 0
    end
    coaches
  end

  def current_season_game_teams(season)
    current = @game_teams_collection.find_all do |game|
    current_season_games(season).include?(game.game_id)
    end
  end

  def coach_win_loss_results(season, high_low)
    coaches_win = coaches_hash
    coaches_lose = coaches_hash
    current_season_game_teams(season).each do |game|
      if game.result == "WIN"
        coaches_win[game.head_coach] += 1
      elsif game.result == "LOSS"
        coaches_lose[game.head_coach] += 1
      end
    end
    if high_low == "high"
    winning_coach = coaches_win.max_by {|coach| coach[1]}
    winning_coach[0]
    elsif high_low == "low"
    losing_coach = coaches_lose.max_by {|coach| coach[1]}
    losing_coach[0]
    end
  end


  #
  #
  #   coaches = coaches_hash
  #
  #     coaches[head_coach] += 1




end
