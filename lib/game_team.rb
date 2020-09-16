require 'csv'

class GameTeam
  attr_reader :game_id,
              :team_id,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(data, manager)
    @game_id = data['game_id']
    @team_id = data['team_id']
    @result = data['result']
    @head_coach = data['head_coach']
    @goals = data['goals'].to_i
    @shots = data['shots'].to_i
    @tackles = data['tackles'].to_i
  end

  def stats
    {
    team_id: @team_id,
    goals: @goals,
    head_coach: @head_coach
    }
  end
end
