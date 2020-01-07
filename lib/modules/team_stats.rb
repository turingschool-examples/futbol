require_relative './calculateable'
require_relative './gatherable'

module TeamStats
  include Calculateable
  include Gatherable
  
  def most_goals_scored(team_id)
    team_goals = []
    @games.collection.each do |game|
      if game.last.home_team_id == team_id
        team_goals << game.last.home_goals.to_i
      elsif game.last.away_team_id == team_id
        team_goals << game.last.away_goals.to_i
      end
    end
    team_goals.max
  end

  def fewest_goals_scored(team_id)
    team_goals = []
    @games.collection.each do |game|
      if game.last.home_team_id == team_id
        team_goals << game.last.home_goals.to_i
      elsif game.last.away_team_id == team_id
        team_goals << game.last.away_goals.to_i
      end
    end
    team_goals.min
  end

  def worst_loss(team_id)
    team_goal_diff = []
    @games.collection.each do |game|
      if game.last.home_team_id == team_id && game.last.home_goals < game.last.away_goals
        team_goal_diff << game.last.away_goals.to_i - game.last.home_goals.to_i
      elsif game.last.away_team_id == team_id && game.last.away_goals < game.last.home_goals
        team_goal_diff << game.last.home_goals.to_i - game.last.away_goals.to_i
      end
    end
    team_goal_diff.max
  end
end
