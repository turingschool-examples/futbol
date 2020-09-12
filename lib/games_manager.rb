require 'csv'
require_relative './stat_tracker'
require_relative './game'
require './lib/manageable'

class GamesManager
  include Manageable

  attr_reader :stat_tracker, :games

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @games = []
    create_games(path)
  end

  def create_games(games_table)
    @games = games_table.map do |data|
      Game.new(data)
    end
  end

  def lowest_total_score
    @games.min_by do |game|
      game.total_game_score
    end.total_game_score
  end

  def highest_total_score
    @games.max_by do |game|
      game.total_game_score
    end.total_game_score
  end

  def percentage_home_wins
     wins = @games.count do |game|
       game.home_is_winner?
     end
     ratio(wins, total_games)
   end

   def percentage_visitor_wins
    wins = @games.count do |game|
      game.visitor_is_winner?
    end
    ratio(wins, total_games)
  end

  def total_team_wins
    games = @games.group_by do |game|
      game.winner_id
    end
    total_team_wins = {}
    games.each do |team_id, game|
      if team_id != 'tie'
        total_team_wins[team_id] = game.count
      end
    end
    total_team_wins
  end

  def total_team_wins_by_season
    @games.reduce(Hash.new) do |hash, game|
      if game.winner_id
        if hash[game.winner_id][game.season]
          hash[game.winner_id][game.season] += 1
        else
          hash[game.winner_id] = {game.season => 1}
        end
      end
      hash
    end
  end


  def percentage_wins_by_season
  end

  def total_games
    @games.count
  end

  def season_group
    @games.group_by do |row|
      row.season
    end
  end

  def count_of_games_by_season
    count = {}
    season_group.each do |season, games|
      count[season] = games.count
    end
    count
  end


end
