require 'csv'
require_relative 'game'
require_relative 'game_team'

class SeasonPerformance

  def self.best_season
    #Season with the highest win percentage for a team.
    #input team_id and receive season
    hash = {}
  x =  GameTeam.all_game_teams.map do |game_team|
      hash[game_team.game_id] = game_team.team_id = wins
    end
  end

  def self.teams_that_won
    win_hash = {}
    if win_hash.key?(x.team_id)
      win_hash[x.team_id] += 1
    else
      win_hash[x.team_id] = 1
    end
    require "pry"; binding.pry
    win_hash
  end

  def self.get_season_from_game_id(game_id)
    Game.all_games.find do |game|
      game.game_id == game_id
      game.season
    end
  end
end
