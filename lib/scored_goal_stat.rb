require_relative 'team_collection'
require_relative 'game_team_collection'
require_relative 'game_collection'

class ScoredGoalStat

  def initialize(team_file_path, game_team_file_path, game_file_path)
    @team_collection = TeamCollection.new(team_file_path)
    @game_team_collection = GameTeamCollection.new(game_team_file_path)
    @game_collection = GameCollection.new(game_file_path)
  end

  def most_goals_scored(team_id)
    total_goals_scored(team_id).max
  end

  def fewest_goals_scored(team_id)
    total_goals_scored(team_id).min
  end

  def total_goals_scored(team_id)
    @game_team_collection.game_team_list.map do |game_team|
      if game_team.team_id.to_s == team_id
        game_team.goals
      end
    end.compact
  end

  def biggest_team_blowout(team_id, use_greater = true)
    win_loss_logic(team_id, use_greater)
  end

  def worst_loss(team_id, use_greater = false)
    win_loss_logic(team_id, use_greater)
  end

  def win_loss_logic(team_id, use_greater)
    win_loss = {}
    @game_collection.games_list.map do |game|
      if game.away_team_id.to_s == team_id || game.home_team_id.to_s == team_id
        if game.away_team_id.to_s == team_id &&
            ((game.away_goals > game.home_goals && use_greater) ||
                (game.home_goals > game.away_goals && !use_greater))
          win_loss[game.game_id.to_s] = (game.away_goals - game.home_goals).abs
        end
      end
    end
    win_loss.values.max
  end

  def favorite_opponent(team_id)
    min_average_wins = average_opponent_games(team_id).min_by { |opponent_id, average| average }
    retrieve_team_name(min_average_wins.first)
  end

  def rival(team_id)
    max_average_wins = average_opponent_games(team_id).max_by { |opponent_id, average| average }
    retrieve_team_name(max_average_wins.first)
  end

  def opponent_games(team_id)
    create_list_opponent_games(team_id, lost_games = false)
  end

  def given_team_games_lost(team_id)
    create_list_opponent_games(team_id, lost_games = true)
  end

  def create_list_opponent_games(team_id, lost_games)
    @game_collection.games_list.reduce({}) do |acc, game|
      if ((game.away_team_id.to_s == team_id && (game.away_goals < game.home_goals)) && lost_games) ||
          (game.away_team_id.to_s == team_id && !lost_games)
        (acc[game.home_team_id.to_s] ||= []) << game.game_id.to_s
      elsif  ((game.home_team_id.to_s == team_id && (game.home_goals < game.away_goals)) && lost_games) ||
          (game.home_team_id.to_s == team_id && !lost_games)
        (acc[game.away_team_id.to_s] ||= []) << game.game_id.to_s
      end
      acc
    end
  end

  def total_opponent_games(team_id)
    total_games_played = {}
    opponent_games(team_id).map do |opponent_id, game_id|
      total_games_played[opponent_id] = game_id.length
    end
    total_games_played
  end

  def total_given_team_losses(team_id)
    total_games_lost = {}
    given_team_games_lost(team_id).map do |opponent_id, game_id|
      total_games_lost[opponent_id] = game_id.length
    end
    total_games_lost
  end

  def average_opponent_games(team_id)
    total_given_team_losses(team_id).merge(total_opponent_games(team_id)) do |opponent_id, old, new|
      (old.to_f / new) * 100
    end
  end

  def retrieve_team_name(team_id)
    @team_collection.teams_list.map do |team|
      if team.team_id.to_s == team_id
        team.team_name
      end
    end.compact.first
  end
end
