require 'csv'

class GameTeam
  attr_reader :game_id, :team_id, :h_o_a, :result, :settled_in, :head_coach

  def initialize(data)
    @game_id = data['game_id'].to_i
    @team_id = data['team_id'].to_i
    @h_o_a = data['HoA']
    @result = data['result']
    @settled_in = data['settled_in']
    @head_coach = data['head_coach']
  end
end
