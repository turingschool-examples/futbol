require 'csv'

class GameTeams
  attr_reader :game_id, :team_id, :h_o_a, :result, :settled_in, :head_coach
  attr_reader :goals, :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals
  attr_reader :face_off_win_percentage, :give_aways, :take_aways

  def initialize(data)
    @game_id = data['game_id'].to_i
    @team_id = data['team_id'].to_i
    @h_o_a = data['HoA']
    @result = data['result']
    @settled_in = data['settled_in']
    @head_coach = data['head_coach']
    @goals = data['goals'].to_i
    @shots = data['shots'].to_i
    @tackles = data['tackles'].to_i
    @pim = data['pim'].to_i
    @power_play_opportunities = data['powerPlayOpportunities'].to_i
    @power_play_goals = data['powerPlayGoals'].to_i
    @face_off_win_percentage = data['faceOffWinPercentage'].to_f
    @give_aways = data['giveaways'].to_i
    @take_aways = data['takeaways'].to_i
  end
end
