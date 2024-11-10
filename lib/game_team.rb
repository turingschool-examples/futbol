require 'csv'
require 'pry'
  
class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :give_aways, :take_aways

  def initialize(data)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @hoa = data["HoA"]
    @result = data["result"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"]
    @shots = data["shots"]
    @tackles = data["tackles"]
    @pim = data["pim"]
    @power_play_opportunities = data["powerPlayOpportunities"]
    @power_play_goals = data["powerPlayGoals"]
    @face_off_win_percentage = data["faceOffWinPercentage"]
    @give_aways = data["giveaways"]
    @take_aways = data["takeaways"]
  end
end
