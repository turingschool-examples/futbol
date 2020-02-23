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

  def biggest_team_blowout(team_id)
    blowout = {}
    @game_collection.games_list.map do |game|
      if game.away_team_id.to_s == team_id || game.home_team_id.to_s == team_id
        if team_id == game.away_team_id.to_s && game.away_goals >= game.home_goals
          blowout[game.game_id.to_s] = (game.away_goals - game.home_goals).abs
        elsif team_id == game.home_team_id.to_s && game.away_goals < game.home_goals
          blowout[game.game_id.to_s] = (game.away_goals - game.home_goals).abs
        end
      end
    end
    blowout.values.max
  end

  def worst_loss(team_id)
    loss = {}
    @game_collection.games_list.map do |game|
      if game.away_team_id.to_s == team_id || game.home_team_id.to_s == team_id
        if team_id == game.away_team_id.to_s && game.away_goals < game.home_goals
          loss[game.game_id.to_s] = (game.away_goals - game.home_goals).abs
        elsif team_id == game.home_team_id.to_s && game.away_goals >= game.home_goals
          loss[game.game_id.to_s] = (game.away_goals - game.home_goals).abs
        end
      end
    end
    loss.values.max
  end

  def favorite_opponent(team_id)
    min_average_wins = average_opponent_games(team_id).min.first
    retrieve_team_name(min_average_wins)
  end

  def rival(team_id)
    max_average_wins = average_opponent_games(team_id).max.first
    retrieve_team_name(max_average_wins)
  end

  def opponent_games_total(team_id)
    @game_collection.games_list.reduce({}) do |acc, game|
      if game.away_team_id.to_s == team_id
        if acc.include?(game.home_team_id.to_s)
          acc[game.home_team_id.to_s] = acc[game.home_team_id.to_s] << game.game_id.to_s
        else
          acc[game.home_team_id.to_s] = [game.game_id.to_s]
        end
      elsif game.home_team_id.to_s == team_id
        if acc.include?(game.away_team_id.to_s)
          acc[game.away_team_id.to_s] = acc[game.away_team_id.to_s] << game.game_id.to_s
        else
          acc[game.away_team_id.to_s] = [game.game_id.to_s]
        end
      end
      acc
    end
  end

  def given_team_loss_games_total(team_id)
    @game_collection.games_list.reduce({}) do |acc, game|
      if (game.away_team_id.to_s == team_id) && (game.away_goals < game.home_goals)
        if acc.include?(game.home_team_id.to_s)
          acc[game.home_team_id.to_s] = acc[game.home_team_id.to_s] << game.game_id.to_s
        else
          acc[game.home_team_id.to_s] = [game.game_id.to_s]
        end
      elsif (game.home_team_id.to_s == team_id) && (game.home_goals < game.away_goals)
        if acc.include?(game.away_team_id.to_s)
          acc[game.away_team_id.to_s] = acc[game.away_team_id.to_s] << game.game_id.to_s
        else
          acc[game.away_team_id.to_s] = [game.game_id.to_s]
        end
      end
      acc
    end
  end

  def number_of_total_opponent_games(team_id)
    total_games_played = {}
    opponent_games_total(team_id).map do |team_id, game_id|
      total_games_played[team_id] = game_id.length
    end
    total_games_played
  end

  def number_of_total_team_losses(team_id)
    total_games_lost = {}
    given_team_loss_games_total(team_id).map do |team_id, game_id|
      total_games_lost[team_id] = game_id.length
    end
    total_games_lost
  end

  def average_opponent_games(team_id)
    average_wins = {}
    number_of_total_opponent_games(team_id).map do |key, value|
      total_losses = number_of_total_team_losses(team_id)[key]
      if total_losses != nil
        average_wins[key] = ((value.to_f / total_losses) * 100).round(2)
      end
    end
    average_wins
  end

  def retrieve_team_name(team_id)
    @team_collection.teams_list.map do |team|
      if team.team_id.to_s == team_id
        team.team_name
      end
    end.compact.first
  end
end