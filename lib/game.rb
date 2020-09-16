require 'csv'

class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(data, manager)
    @game_id = data['game_id']
    @season = data['season']
    @away_team_id = data['away_team_id']
    @home_team_id = data['home_team_id']
    @away_goals = data['away_goals'].to_i
    @home_goals = data['home_goals'].to_i
  end
  
  def stats
    {
    away_team_id: @away_team_id,
    home_team_id: @home_team_id,
    away_goals: @away_goals,
    home_goals: @home_goals
    }
  end
end
