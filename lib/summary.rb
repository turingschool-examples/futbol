require_relative 'team_collection'
require_relative 'game_team_collection'
require_relative 'game_collection'

class Summary

  def initialize(team_file_path, game_team_file_path, game_file_path)
    @team_collection = TeamCollection.new(team_file_path)
    @game_team_collection = GameTeamCollection.new(game_team_file_path)
    @game_collection = GameCollection.new(game_file_path)
  end

  def head_to_head(team_id)
    convert_id_to_name(team_id)
  end

  def list_opponent_games(team_id)
    create_opponent_game_id_list(team_id, won_games = false)
  end

  def list_given_team_won_games(team_id)
    create_opponent_game_id_list(team_id, won_games = true)
  end

  def create_opponent_game_id_list(team_id, won_games)
    @game_collection.games_list.reduce({}) do |acc, game|
      if ((game.away_team_id.to_s == team_id && (game.away_goals > game.home_goals)) && won_games) ||
          (game.away_team_id.to_s == team_id && !won_games)
        (acc[game.home_team_id.to_s] ||= []) << game.game_id.to_s
      elsif  ((game.home_team_id.to_s == team_id && (game.home_goals > game.away_goals)) && won_games) ||
          (game.home_team_id.to_s == team_id && !won_games)
        (acc[game.away_team_id.to_s] ||= []) << game.game_id.to_s
      end
      acc
    end
  end

  def total_opponent_games(team_id)
    total_games_played = {}
    list_opponent_games(team_id).map do |opponent_id, game_id|
      total_games_played[opponent_id] = game_id.length
    end
    total_games_played
  end

  def total_given_team_wins(team_id)
    total_games_won = {}
    list_given_team_won_games(team_id).map do |opponent_id, game_id|
      total_games_won[opponent_id] = game_id.length
    end
    total_games_won
  end

  def average_won_games(team_id)
    total_given_team_wins(team_id).merge(total_opponent_games(team_id)) do |opponent_id, old, new|
      (old.to_f / new).round(2)
    end
  end

  def convert_id_to_name(team_id)
    new_hash = {}
    average_won_games(team_id).map do |key, value|
      new_hash[retrieve_team_name(key)] = value
    end
    new_hash
  end

  def retrieve_team_name(team_id)
    @team_collection.teams_list.map do |team|
      if team.team_id.to_s == team_id
        team.team_name
      end
    end.compact.first
  end
end