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
end